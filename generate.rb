require './parser'

nouns = open("n.txt").read.split("\n")
adjectives = open("adj.txt").read.split("\n")
verbs = open("v.txt").read.split("\n")

sentences = ["A <adj:lonely> <n:cab-horse> <v:steams> and <v:stamps>.",
"And now a <adj:gusty> <n:shower> <v:wraps>",
"Let us go then, <n:you> and <n:I>,/When the <n:evening> is <adj:spread> out against the <n:sky>/Like a <n:patient> <adj:etherised> upon a <n:table>;",
"Now <v:sleeps> the <adj:crimson> <n:petal>, now the <adj:white>;",
"Now <v:droops> the <adj:milk-white> <n:peacock> like a <n:ghost>, And like a <n:ghost> she <n:glimmers> on to me.",
"Once upon a <n:midnight> dreary while I <v:pondered> <adj:weak> and <adj:weary>",
"My mistress' <n:eyes> are nothing like the <n:sun>;",
"<adj:Grave> <n:men>, near <n:death>, who <v:see> with <adj:blinding> <n:sight>
<adj:Blind> <n:eyes> could <v:blaze> like <n:meteors> and be <adj:gay>,
<v:Rage>, <v:rage> against the <v:dying> of the <n:light>.",
"<adj:Wild> <n:men> who <v:caught> and <v:sang> the <n:sun> in <v:flight>,
And <v:learn>, too late, they <v:grieved> it on its way,
Do not go <adj:gentle> into that <adj:good> <n:night>."
]

replacements = {"adj" => adjectives, 
				"v" => verbs,
				"n" => nouns}


sentences.each do |s|
	pos = Parser.parse(s)
		
	result = []
	
	pos.each_with_index do |entry, i|
	
		if entry.keys[0] == :tag
			candidates = replacements[entry[:tag][:pos]]
			first_letter = entry[:tag][:original].chars.first.downcase

			candidates = candidates.select{|word| word.chars.first == first_letter}

			if candidates.length > 0
				result << candidates.sample
			else
				result << entry[:tag][:original]
			end
		elsif entry.keys[0] == :word
			result <<  entry.values[0]
		else 
			result.last << entry.values[0]
		end
	
	end
	
	puts "#{result.join(" ")} (#{result.join(" ").length})"
end