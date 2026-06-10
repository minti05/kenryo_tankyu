-- =============================================================
-- Supabase RLS (Row Level Security) ポリシー設定
-- 前提: Supabase Dashboard > Authentication > Third-party Auth
--       で Firebase プロジェクトを登録済みであること
-- =============================================================

-- browsing_history
ALTER TABLE browsing_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "browsing_history: 本人のみ全操作可"
  ON browsing_history
  FOR ALL
  USING (auth.uid()::text = user_id)
  WITH CHECK (auth.uid()::text = user_id);

-- favorites
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

CREATE POLICY "favorites: 本人のみ全操作可"
  ON favorites
  FOR ALL
  USING (auth.uid()::text = user_id)
  WITH CHECK (auth.uid()::text = user_id);

-- search_history
ALTER TABLE search_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "search_history: 本人のみ全操作可"
  ON search_history
  FOR ALL
  USING (auth.uid()::text = user_id)
  WITH CHECK (auth.uid()::text = user_id);

-- notification_reads
ALTER TABLE notification_reads ENABLE ROW LEVEL SECURITY;

CREATE POLICY "notification_reads: 本人のみ全操作可"
  ON notification_reads
  FOR ALL
  USING (auth.uid()::text = user_id)
  WITH CHECK (auth.uid()::text = user_id);
