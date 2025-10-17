local m = {
	"[Informação] Gostaria de efetuar uma doação? use o comando !donate",
	"[Promoção] Compras abaixo de R$: 99,00 você recebe 50%, acima de 100,00 você recebe double diamond.",
}

function onThink()
	doBroadcastMessage("yellow | [Mensagem automática]: ".. m[math.random(1,#m)])
	-- doBroadcastMessage("[Informação] Gostaria de efetuar uma doação? use o comando !donate.")
	return TRUE
end