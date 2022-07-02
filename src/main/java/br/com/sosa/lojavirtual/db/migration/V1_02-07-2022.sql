SELECT constraint_name FROM information_schema.constraint_column_usage
    WHERE table_name = 'usuarios_acesso' AND collumn_name = 'acesso_id'
    AND constraint_name <> 'unique_acesso_user';

ALTER TABLE usuario_acesso DROP CONSTRAINT "uk_ly2kfklascbpohfq3x7yo2dpv";