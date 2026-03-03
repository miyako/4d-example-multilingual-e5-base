//%attributes = {}
var $en; $fr : 4D:C1709.Vector
var $AIClient : cs:C1710.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs:C1710.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8082/v1"  // CTranslate2

$fr:=$AIClient.embeddings.create("query: Comment réinitialiser mon mot de passe?").embedding.embedding
$en:=$AIClient.embeddings.create("passage: To reset your password you must contanct customer support.").embedding.embedding

$cosineSimilarity:=$fr.cosineSimilarity($en)
//0.836891039498

ALERT:C41([$cosineSimilarity].join())

/*

this model is quite slow on cpu...

*/