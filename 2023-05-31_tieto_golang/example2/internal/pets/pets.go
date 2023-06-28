package pets

import (
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type Pet struct {
	gorm.Model
	Name string
	Age  int
	Kind string `gorm:"default:generic"`
}

type DB struct {
	db *gorm.DB
}

func NewDB(dsn string) (DB, error) {
	db := DB{}
	newDb, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return db, err
	}
	db.db = newDb
	return db, nil
}

func (db DB) Migrate() {
	db.db.AutoMigrate(&Pet{})
}

func (db DB) CreatePet(name string, age int, kind string) {
	db.db.Create(&Pet{
		Name: name,
		Age:  age,
		Kind: kind,
	})
}

func (db DB) ListPets() []Pet {
	pets := []Pet{}
	db.db.Find(&pets)
	return pets
}
