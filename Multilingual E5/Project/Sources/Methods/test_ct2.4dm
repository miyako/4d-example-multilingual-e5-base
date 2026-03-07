//%attributes = {}
var $en; $fr : 4D:C1709.Vector
var $AIClient : cs:C1710.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs:C1710.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8082/v1"  // CTranslate2

$batch:=$AIClient.embeddings.create(["query: Comment réinitialiser mon mot de passe?"; "passage: To reset your password you must contanct customer support."])

$fr:=$batch.embeddings[0].embedding
$en:=$batch.embeddings[1].embedding

$cosineSimilarity:=$fr.cosineSimilarity($en)
//0.83689103949804

ALERT:C41([$cosineSimilarity].join())

/*

this model is quite slow on cpu...

*/