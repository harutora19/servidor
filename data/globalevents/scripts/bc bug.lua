local m = {
	"[Informa��o] Gostaria de efetuar uma doa��o? use o comando !donate",
	"[Promo��o] Compras abaixo de R$: 99,00 voc� recebe 50%, acima de 100,00 voc� recebe double diamond.",
}

function onThink()
	doBroadcastMessage("yellow | [Mensagem autom�tica]: ".. m[math.random(1,#m)])
	-- doBroadcastMessage("[Informa��o] Gostaria de efetuar uma doa��o? use o comando !donate.")
	return TRUE
end