package pets

type Pet struct {
	name string
}

func (p Pet) Name() string {
	return p.name
}

func (p *Pet) SetName(name string) {
	p.name = name
}

func Name(p Pet) string {
	return p.name
}

func SetName(p *Pet, name string) {
	p.name = name
}
