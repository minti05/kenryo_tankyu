# Logic Flow of Dependency Injection

このシーケンス図は、アプリケーションの起動から、各レイヤー（Presentation, Domain, Data）で依存性がどのように解決・注入されるかを示しています。

```mermaid
sequenceDiagram
    participant Main as main()
    participant Ext as External Services<br/>(Firebase, SharedPreferences)
    participant Scope as ProviderScope
    participant UI as Widget/Consumer (Login Page)
    participant Notifier as AuthNotifier<br/>(Presentation Layer)
    participant Repo as AuthRepository<br/>(Data/Domain Layer)
    participant Source as DataSourceProvider<br/>(Core Layer)

    Note over Main, Scope: 1. 初期化フェーズ (Strict Main Injection)
    Main->>Ext: await Firebase.initializeApp()
    Main->>Ext: await SharedPreferences.getInstance()
    Ext-->>Main: インスタンス返却
    Main->>Scope: runApp(ProviderScope)<br/>overrides: [sharedPrefsProvider]
    Note right of Scope: ここでSharedPreferencesの実態が<br/>Riverpodのコンテナに登録されます

    Note over UI, Source: 2. 利用フェーズ (Provider Chain)
    UI->>Scope: ref.watch(authNotifierProvider)
    
    %% AuthNotifierの生成プロセス
    Scope->>Notifier: AuthNotifierを作成
    Notifier->>Scope: ref.read(authRepositoryProvider)を要求
    
    %% Repositoryの生成プロセス
    Scope->>Repo: AuthRepositoryを作成
    Repo->>Scope: ref.watch(firebaseAuthProvider)を要求
    
    %% Data Sourceの解決
    Scope->>Source: FirebaseAuthインスタンスを取得
    Source-->>Repo: FirebaseAuth Instance
    Repo-->>Notifier: Repository Instance (with DataSource)
    
    %% 完了
    Notifier-->>UI: AuthNotifier Instance (with Repository)
```

## 解説
1.  **初期化 (Main)**:
    *   `main()` 関数内で `Firebase` や `SharedPreferences` などの外部サービスを **await** して確実に初期化します。
    *   初期化したインスタンスは `ProviderScope` の `overrides` を通じてアプリ全体に注入されます。これにより、アプリ内のどこからでも同期的かつ安全にアクセス可能になります。

2.  **依存の解決 (Providers)**:
    *   **UI** は `Notifier` を要求します。
    *   **Notifier** はビジネスロジックを実行するために `Repository` を要求します。
    *   **Repository** はデータ操作を行うために `Data Source (Firebase等)` を要求します。
    *   Riverpodの仕組みにより、これらの依存関係は自動的に解決され、必要なインスタンスが順次第生成・注入されます。
