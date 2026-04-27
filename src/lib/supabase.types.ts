export interface Vote {
  id: number;
  created_at: string;
}

export interface Confessione {
  id: number;
  testo: string;
  created_at: string;
}

export interface ConfessioneLocal extends Omit<Confessione, 'id'> {
  id: number | string;
  _optimistic?: boolean;
}

export interface Database {
  public: {
    Tables: {
      votes: {
        Row: Vote;
        Insert: { id?: number; created_at?: string };
        Update: { id?: number; created_at?: string };
      };
      confessioni: {
        Row: Confessione;
        Insert: { id?: number; testo: string; created_at?: string };
        Update: { id?: number; testo?: string; created_at?: string };
      };
    };
  };
}
