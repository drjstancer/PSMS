export interface DatabaseConfig {
  dataFolder: string;
  databaseFile: string;
}

export const defaultConfig: DatabaseConfig = {
  dataFolder: 'PSMS/data',
  databaseFile: 'psms.sqlite'
};

export async function initializeDatabase() {
  console.log('PSMS database initialization placeholder');
}

export async function testConnection() {
  return true;
}
