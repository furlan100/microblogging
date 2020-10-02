class DataBaseCommands {
  List<String> _onCreate = [];
  List<String> _onUpgrade = [];

  List<String> onCreate() {
    _onCreate.add("""CREATE TABLE IF NOT EXISTS config (
        id                    INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,        
        url_api               VARCHAR   NOT NULL                     
        );
        COMMIT;"""
        .trim());

    _onCreate.add("""CREATE TABLE IF NOT EXISTS user (
                        id        INTEGER      PRIMARY KEY UNIQUE,
                        user      VARCHAR (100),
                        password  VARCHAR (100),
                        name      VARCHAR (100)                        
                        );
                        COMMIT;"""
        .trim());

    _onCreate.add("""CREATE TABLE IF NOT EXISTS news (
        id                INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,   
        name              VARCHAR   NOT NULL,
        profile_picture   VARCHAR   NOT NULL,
        content           VARCHAR   NOT NULL,
        created_at        VARCHAR   NOT NULL                             
        );
        COMMIT;"""
        .trim());

    _onCreate.add("""CREATE TABLE IF NOT EXISTS posts (
        id                INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,        
        name              VARCHAR(80)    NOT NULL,        
        content           VARCHAR(280)   NOT NULL,
        created_at        VARCHAR        NOT NULL                             
        );
        COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO config (url_api) VALUES ('https://gb-mobile-app-teste.s3.amazonaws.com/');
                                COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO user (id,user,password,name) VALUES (1,'furlan@boticario.com', 'senha', 'Guilherme Furlan');
           COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO posts (name,content,created_at) 
           VALUES (
           'Guilherme Furlan',
           'Boticário Contrata Guilherme Furlan',
           '2020-02-02T16:00:00Z');
           COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO posts (name,content,created_at) 
           VALUES (
           'Administrador',
           'PRODUTOS CADA DIA MAIS SUSTENTÁVEIS Sustentabilidade na embalagem, formulação, distribuição e comercialização.',
           '2020-02-01T16:00:00Z');
           COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO posts (name,content,created_at) 
           VALUES (
           'Administrador',
           'DURANTE A FABRICAÇÃO E A DISTRIBUIÇÃO, ECOFICIÊNCIA! Interação com o meio ambiente visa a redução do impacto em toda a operação',
           '2020-02-01T16:00:00Z');
           COMMIT;"""
        .trim());

    _onCreate.add("""INSERT INTO posts (name,content,created_at) 
           VALUES (
           'Administrador',
           'Em 2020, vamos celebrar 20 anos sem testes em animais. Mas como garantimos que os nossos produtos são totalmente seguros para as pessoas? Descubra neste vídeo os principais métodos alternativos que aplicamos em nosso Centro de Pesquisa & Desenvolvimento.',
           '2020-02-09T16:00:00Z');
           COMMIT;"""
        .trim());

    return _onCreate;
  }

  List<String> onUpgrade() {
    return _onUpgrade;
  }
}
