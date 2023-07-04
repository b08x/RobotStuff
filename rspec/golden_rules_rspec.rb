context "Golden Rules (English)" do
  it "Simple period to end sentence #001" do
    text = Segmenter::Text.new(text: "Hello World. My name is Jonas.", language: "en")
    expect(text.segment).to eq(["Hello World.", "My name is Jonas."])
  end

  it "Question mark to end sentence #002" do
    text = Segmenter::Text.new(text: "What is your name? My name is Jonas.", language: "en")
    expect(text.segment).to eq(["What is your name?", "My name is Jonas."])
  end

  it "Exclamation point to end sentence #003" do
    text = Segmenter::Text.new(text: "There it is! I found it.", language: "en")
    expect(text.segment).to eq(["There it is!", "I found it."])
  end

  it "One letter upper case abbreviations #004" do
    text = Segmenter::Text.new(text: "My name is Jonas E. Smith.", language: "en")
    expect(text.segment).to eq(["My name is Jonas E. Smith."])
  end

  it "One letter lower case abbreviations #005" do
    text = Segmenter::Text.new(text: "Please turn to p. 55.", language: "en")
    expect(text.segment).to eq(["Please turn to p. 55."])
  end

  it "Two letter lower case abbreviations in the middle of a sentence #006" do
    text = Segmenter::Text.new(text: "Were Jane and co. at the party?", language: "en")
    expect(text.segment).to eq(["Were Jane and co. at the party?"])
  end

  it "Two letter upper case abbreviations in the middle of a sentence #007" do
    text = Segmenter::Text.new(text: "They closed the deal with Pitt, Briggs & Co. at noon.", language: "en")
    expect(text.segment).to eq(["They closed the deal with Pitt, Briggs & Co. at noon."])
  end

  it "Two letter lower case abbreviations at the end of a sentence #008" do
    text = Segmenter::Text.new(text: "Let's ask Jane and co. They should know.", language: "en")
    expect(text.segment).to eq(["Let's ask Jane and co.", "They should know."])
  end

  it "Two letter upper case abbreviations at the end of a sentence #009" do
    text = Segmenter::Text.new(text: "They closed the deal with Pitt, Briggs & Co. It closed yesterday.", language: "en")
    expect(text.segment).to eq(["They closed the deal with Pitt, Briggs & Co.", "It closed yesterday."])
  end

  it "Two letter (prepositive) abbreviations #010" do
    text = Segmenter::Text.new(text: "I can see Mt. Fuji from here.", language: "en")
    expect(text.segment).to eq(["I can see Mt. Fuji from here."])
  end

  it "Two letter (prepositive & postpositive) abbreviations #011" do
    text = Segmenter::Text.new(text: "St. Michael's Church is on 5th st. near the light.", language: "en")
    expect(text.segment).to eq(["St. Michael's Church is on 5th st. near the light."])
  end

  it "Possesive two letter abbreviations #012" do
    text = Segmenter::Text.new(text: "That is JFK Jr.'s book.", language: "en")
    expect(text.segment).to eq(["That is JFK Jr.'s book."])
  end

  it "Multi-period abbreviations in the middle of a sentence #013" do
    text = Segmenter::Text.new(text: "I visited the U.S.A. last year.", language: "en")
    expect(text.segment).to eq(["I visited the U.S.A. last year."])
  end

  it "Multi-period abbreviations at the end of a sentence #014" do
    text = Segmenter::Text.new(text: "I live in the E.U. How about you?", language: "en")
    expect(text.segment).to eq(["I live in the E.U.", "How about you?"])
  end

  it "U.S. as sentence boundary #015" do
    text = Segmenter::Text.new(text: "I live in the U.S. How about you?", language: "en")
    expect(text.segment).to eq(["I live in the U.S.", "How about you?"])
  end

  it "U.S. as non sentence boundary with next word capitalized #016" do
    text = Segmenter::Text.new(text: "I work for the U.S. Government in Virginia.", language: "en")
    expect(text.segment).to eq(["I work for the U.S. Government in Virginia."])
  end

  it "U.S. as non sentence boundary #017" do
    text = Segmenter::Text.new(text: "I have lived in the U.S. for 20 years.", language: "en")
    expect(text.segment).to eq(["I have lived in the U.S. for 20 years."])
  end

  it "A.M. / P.M. as non sentence boundary and sentence boundary #018" do
    text = Segmenter::Text.new(text: "At 5 a.m. Mr. Smith went to the bank. He left the bank at 6 P.M. Mr. Smith then went to the store.", language: "en")
    expect(text.segment).to eq(["At 5 a.m. Mr. Smith went to the bank.", "He left the bank at 6 P.M.", "Mr. Smith then went to the store."])
  end

  it "Number as non sentence boundary #019" do
    text = Segmenter::Text.new(text: "She has $100.00 in her bag.", language: "en")
    expect(text.segment).to eq(["She has $100.00 in her bag."])
  end

  it "Number as sentence boundary #020" do
    text = Segmenter::Text.new(text: "She has $100.00. It is in her bag.", language: "en")
    expect(text.segment).to eq(["She has $100.00.", "It is in her bag."])
  end

  it "Parenthetical inside sentence #021" do
    text = Segmenter::Text.new(text: "He teaches science (He previously worked for 5 years as an engineer.) at the local University.", language: "en")
    expect(text.segment).to eq(["He teaches science (He previously worked for 5 years as an engineer.) at the local University."])
  end

  it "Email addresses #022" do
    text = Segmenter::Text.new(text: "Her email is Jane.Doe@example.com. I sent her an email.", language: "en")
    expect(text.segment).to eq(["Her email is Jane.Doe@example.com.", "I sent her an email."])
  end

  it "Web addresses #023" do
    text = Segmenter::Text.new(text: "The site is: https://www.example.50.com/new-site/awesome_content.html. Please check it out.", language: "en")
    expect(text.segment).to eq(["The site is: https://www.example.50.com/new-site/awesome_content.html.", "Please check it out."])
  end

  it "Single quotations inside sentence #024" do
    text = Segmenter::Text.new(text: "She turned to him, 'This is great.' she said.", language: "en")
    expect(text.segment).to eq(["She turned to him, 'This is great.' she said."])
  end

  it "Double quotations inside sentence #025" do
    text = Segmenter::Text.new(text: "She turned to him, \"This is great.\" she said.", language: "en")
    expect(text.segment).to eq(["She turned to him, \"This is great.\" she said."])
  end

  it "Double quotations at the end of a sentence #026" do
    text = Segmenter::Text.new(text: "She turned to him, \"This is great.\" She held the book out to show him.", language: "en")
    expect(text.segment).to eq(["She turned to him, \"This is great.\"", "She held the book out to show him."])
  end

  it "Double punctuation (exclamation point) #027" do
    text = Segmenter::Text.new(text: "Hello!! Long time no see.", language: "en")
    expect(text.segment).to eq(["Hello!!", "Long time no see."])
  end

  it "Double punctuation (question mark) #028" do
    text = Segmenter::Text.new(text: "Hello?? Who is there?", language: "en")
    expect(text.segment).to eq(["Hello??", "Who is there?"])
  end

  it "Double punctuation (exclamation point / question mark) #029" do
    text = Segmenter::Text.new(text: "Hello!? Is that you?", language: "en")
    expect(text.segment).to eq(["Hello!?", "Is that you?"])
  end

  it "Double punctuation (question mark / exclamation point) #030" do
    text = Segmenter::Text.new(text: "Hello?! Is that you?", language: "en")
    expect(text.segment).to eq(["Hello?!", "Is that you?"])
  end

  it "List (period followed by parens and no period to end item) #031" do
    text = Segmenter::Text.new(text: "1.) The first item 2.) The second item", language: "en")
    expect(text.segment).to eq(["1.) The first item", "2.) The second item"])
  end

  it "List (period followed by parens and period to end item) #032" do
    text = Segmenter::Text.new(text: "1.) The first item. 2.) The second item.", language: "en")
    expect(text.segment).to eq(["1.) The first item.", "2.) The second item."])
  end

  it "List (parens and no period to end item) #033" do
    text = Segmenter::Text.new(text: "1) The first item 2) The second item", language: "en")
    expect(text.segment).to eq(["1) The first item", "2) The second item"])
  end

  it "List (parens and period to end item) #034" do
    text = Segmenter::Text.new(text: "1) The first item. 2) The second item.", language: "en")
    expect(text.segment).to eq(["1) The first item.", "2) The second item."])
  end

  it "List (period to mark list and no period to end item) #035" do
    text = Segmenter::Text.new(text: "1. The first item 2. The second item", language: "en")
    expect(text.segment).to eq(["1. The first item", "2. The second item"])
  end

  it "List (period to mark list and period to end item) #036" do
    text = Segmenter::Text.new(text: "1. The first item. 2. The second item.", language: "en")
    expect(text.segment).to eq(["1. The first item.", "2. The second item."])
  end

  it "List with bullet #037" do
    text = Segmenter::Text.new(text: "• 9. The first item • 10. The second item", language: "en")
    expect(text.segment).to eq(["• 9. The first item", "• 10. The second item"])
  end

  it "List with hypthen #038" do
    text = Segmenter::Text.new(text: "⁃9. The first item ⁃10. The second item", language: "en")
    expect(text.segment).to eq(["⁃9. The first item", "⁃10. The second item"])
  end

  it "Alphabetical list #039" do
    text = Segmenter::Text.new(text: "a. The first item b. The second item c. The third list item", language: "en")
    expect(text.segment).to eq(["a. The first item", "b. The second item", "c. The third list item"])
  end

  it "Errant newlines in the middle of sentences (PDF) #040" do
    text = Segmenter::Text.new(text: "This is a sentence\ncut off in the middle because pdf.", language: "en", doc_type: "pdf")
    expect(text.segment).to eq(["This is a sentence cut off in the middle because pdf."])
  end

  it "Errant newlines in the middle of sentences #041" do
    text = Segmenter::Text.new(text: "It was a cold \nnight in the city.", language: "en")
    expect(text.segment).to eq(["It was a cold night in the city."])
  end

  it "Lower case list separated by newline #042" do
    text = Segmenter::Text.new(text: "features\ncontact manager\nevents, activities\n", language: "en")
    expect(text.segment).to eq(["features", "contact manager", "events, activities"])
  end

  it "Geo Coordinates #043" do
    text = Segmenter::Text.new(text: "You can find it at N°. 1026.253.553. That is where the treasure is.", language: "en")
    expect(text.segment).to eq(["You can find it at N°. 1026.253.553.", "That is where the treasure is."])
  end

  it "Named entities with an exclamation point #044" do
    text = Segmenter::Text.new(text: "She works at Yahoo! in the accounting department.", language: "en")
    expect(text.segment).to eq(["She works at Yahoo! in the accounting department."])
  end

  it "I as a sentence boundary and I as an abbreviation #045" do
    text = Segmenter::Text.new(text: "We make a good team, you and I. Did you see Albert I. Jones yesterday?", language: "en")
    expect(text.segment).to eq(["We make a good team, you and I.", "Did you see Albert I. Jones yesterday?"])
  end

  it "Ellipsis at end of quotation #046" do
    text = Segmenter::Text.new(text: "Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .”", language: "en")
    expect(text.segment).to eq(["Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .”"])
  end

  it "Ellipsis with square brackets #047" do
    text = Segmenter::Text.new(text: "\"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55).", language: "en")
    expect(text.segment).to eq(["\"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55)."])
  end

  it "Ellipsis as sentence boundary (standard ellipsis rules) #048" do
    text = Segmenter::Text.new(text: "If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . . Next sentence.", language: "en")
    expect(text.segment).to eq(["If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . .", "Next sentence."])
  end

  it "Ellipsis as sentence boundary (non-standard ellipsis rules) #049" do
    text = Segmenter::Text.new(text: "I never meant that.... She left the store.", language: "en")
    expect(text.segment).to eq(["I never meant that....", "She left the store."])
  end

  it "Ellipsis as non sentence boundary #050" do
    text = Segmenter::Text.new(text: "I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it.", language: "en")
    expect(text.segment).to eq(["I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it."])
  end

  it "4-dot ellipsis #051" do
    text = Segmenter::Text.new(text: "One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds. . . . The practice was not abandoned. . . .", language: "en")
    expect(text.segment).to eq(["One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds.", ". . . The practice was not abandoned. . . ."])
  end
end

context "Golden Rules (languages other than English)" do
  context "Golden Rules (German)" do
    it "Quotation at end of sentence #001" do
      text = Segmenter::Text.new(text: "„Ich habe heute keine Zeit“, sagte die Frau und flüsterte leise: „Und auch keine Lust.“ Wir haben 1.000.000 Euro.", language: "de")
      expect(text.segment).to eq(["„Ich habe heute keine Zeit“, sagte die Frau und flüsterte leise: „Und auch keine Lust.“", "Wir haben 1.000.000 Euro."])
    end

    it "Abbreviations #002" do
      text = Segmenter::Text.new(text: "Es gibt jedoch einige Vorsichtsmaßnahmen, die Du ergreifen kannst, z. B. ist es sehr empfehlenswert, dass Du Dein Zuhause von allem Junkfood befreist.", language: "de")
      expect(text.segment).to eq(["Es gibt jedoch einige Vorsichtsmaßnahmen, die Du ergreifen kannst, z. B. ist es sehr empfehlenswert, dass Du Dein Zuhause von allem Junkfood befreist."])
    end

    it "Numbers #003" do
      text = Segmenter::Text.new(text: "Was sind die Konsequenzen der Abstimmung vom 12. Juni?", language: "de")
      expect(text.segment).to eq(["Was sind die Konsequenzen der Abstimmung vom 12. Juni?"])
    end
  end

  context "Golden Rules (Japanese)" do
    it "Simple period to end sentence #001" do
      text = Segmenter::Text.new(text: "これはペンです。それはマーカーです。", language: "ja")
      expect(text.segment).to eq(["これはペンです。", "それはマーカーです。"])
    end

    it "Question mark to end sentence #002" do
      text = Segmenter::Text.new(text: "それは何ですか？ペンですか？", language: "ja")
      expect(text.segment).to eq(["それは何ですか？", "ペンですか？"])
    end

    it "Exclamation point to end sentence #003" do
      text = Segmenter::Text.new(text: "良かったね！すごい！", language: "ja")
      expect(text.segment).to eq(["良かったね！", "すごい！"])
    end

    it "Quotation #004" do
      text = Segmenter::Text.new(text: "自民党税制調査会の幹部は、「引き下げ幅は３．２９％以上を目指すことになる」と指摘していて、今後、公明党と合意したうえで、３０日に決定する与党税制改正大綱に盛り込むことにしています。２％台後半を目指すとする方向で最終調整に入りました。", language: "ja")
      expect(text.segment).to eq(["自民党税制調査会の幹部は、「引き下げ幅は３．２９％以上を目指すことになる」と指摘していて、今後、公明党と合意したうえで、３０日に決定する与党税制改正大綱に盛り込むことにしています。", "２％台後半を目指すとする方向で最終調整に入りました。"])
    end

    it "Errant newlines in the middle of sentences #005" do
      text = Segmenter::Text.new(text: "これは父の\n家です。", language: "ja")
      expect(text.segment).to eq(["これは父の家です。"])
    end
  end

  context "Golden Rules (Arabic)" do
    it "Regular punctuation #001" do
      text = Segmenter::Text.new(text: "سؤال وجواب: ماذا حدث بعد الانتخابات الايرانية؟ طرح الكثير من التساؤلات غداة ظهور نتائج الانتخابات الرئاسية الايرانية التي أججت مظاهرات واسعة واعمال عنف بين المحتجين على النتائج ورجال الامن. يقول معارضو الرئيس الإيراني إن الطريقة التي اعلنت بها النتائج كانت مثيرة للاستغراب.", language: "ar")
      expect(text.segment).to eq(["سؤال وجواب:", "ماذا حدث بعد الانتخابات الايرانية؟", "طرح الكثير من التساؤلات غداة ظهور نتائج الانتخابات الرئاسية الايرانية التي أججت مظاهرات واسعة واعمال عنف بين المحتجين على النتائج ورجال الامن.", "يقول معارضو الرئيس الإيراني إن الطريقة التي اعلنت بها النتائج كانت مثيرة للاستغراب."])
    end

    it "Abbreviations #002" do
      text = Segmenter::Text.new(text: "وقال د‪.‬ ديفيد ريدي و الأطباء الذين كانوا يعالجونها في مستشفى برمنجهام إنها كانت تعاني من أمراض أخرى. وليس معروفا ما اذا كانت قد توفيت بسبب اصابتها بأنفلونزا الخنازير.", language: "ar")
      expect(text.segment).to eq(["وقال د‪.‬ ديفيد ريدي و الأطباء الذين كانوا يعالجونها في مستشفى برمنجهام إنها كانت تعاني من أمراض أخرى.", "وليس معروفا ما اذا كانت قد توفيت بسبب اصابتها بأنفلونزا الخنازير."])
    end

    it "Numbers and Dates #003" do
      text = Segmenter::Text.new(text: "ومن المنتظر أن يكتمل مشروع خط أنابيب نابوكو البالغ طوله 3300 كليومترا في 12‪/‬08‪/‬2014 بتكلفة تُقدر بـ 7.9 مليارات يورو أي نحو 10.9 مليارات دولار. ومن المقرر أن تصل طاقة ضخ الغاز في المشروع 31 مليار متر مكعب انطلاقا من بحر قزوين مرورا بالنمسا وتركيا ودول البلقان دون المرور على الأراضي الروسية.", language: "ar")
      expect(text.segment).to eq(["ومن المنتظر أن يكتمل مشروع خط أنابيب نابوكو البالغ طوله 3300 كليومترا في 12‪/‬08‪/‬2014 بتكلفة تُقدر بـ 7.9 مليارات يورو أي نحو 10.9 مليارات دولار.", "ومن المقرر أن تصل طاقة ضخ الغاز في المشروع 31 مليار متر مكعب انطلاقا من بحر قزوين مرورا بالنمسا وتركيا ودول البلقان دون المرور على الأراضي الروسية."])
    end

    it "Time #004" do
      text = Segmenter::Text.new(text: "الاحد, 21 فبراير/ شباط, 2010, 05:01 GMT الصنداي تايمز: رئيس الموساد قد يصبح ضحية الحرب السرية التي شتنها بنفسه. العقل المنظم هو مئير داجان رئيس الموساد الإسرائيلي الذي يشتبه بقيامه باغتيال القائد الفلسطيني في حركة حماس محمود المبحوح في دبي.", language: "ar")
      expect(text.segment).to eq(["الاحد, 21 فبراير/ شباط, 2010, 05:01 GMT الصنداي تايمز:", "رئيس الموساد قد يصبح ضحية الحرب السرية التي شتنها بنفسه.", "العقل المنظم هو مئير داجان رئيس الموساد الإسرائيلي الذي يشتبه بقيامه باغتيال القائد الفلسطيني في حركة حماس محمود المبحوح في دبي."])
    end

    it "Comma #005" do
      text = Segmenter::Text.new(text: "عثر في الغرفة على بعض أدوية علاج ارتفاع ضغط الدم، والقلب، زرعها عملاء الموساد كما تقول مصادر إسرائيلية، وقرر الطبيب أن الفلسطيني قد توفي وفاة طبيعية ربما إثر نوبة قلبية، وبدأت مراسم الحداد عليه", language: "ar")
      expect(text.segment).to eq(["عثر في الغرفة على بعض أدوية علاج ارتفاع ضغط الدم، والقلب،", "زرعها عملاء الموساد كما تقول مصادر إسرائيلية،", "وقرر الطبيب أن الفلسطيني قد توفي وفاة طبيعية ربما إثر نوبة قلبية،", "وبدأت مراسم الحداد عليه"])
    end
  end

  context "Golden Rules (Italian)" do
    it "Abbreviations #001" do
      text = Segmenter::Text.new(text: "Salve Sig.ra Mengoni! Come sta oggi?", language: "it")
      expect(text.segment).to eq(["Salve Sig.ra Mengoni!", "Come sta oggi?"])
    end

    it "Quotations #002" do
      text = Segmenter::Text.new(text: "Una lettera si può iniziare in questo modo «Il/la sottoscritto/a.».", language: "it")
      expect(text.segment).to eq(["Una lettera si può iniziare in questo modo «Il/la sottoscritto/a.»."])
    end

    it "Numbers #003" do
      text = Segmenter::Text.new(text: "La casa costa 170.500.000,00€!", language: "it")
      expect(text.segment).to eq(["La casa costa 170.500.000,00€!"])
    end
  end

  context "Golden Rules (Russian)" do
    it "Abbreviations #001" do
      text = Segmenter::Text.new(text: "Объем составляет 5 куб.м.", language: "ru")
      expect(text.segment).to eq(["Объем составляет 5 куб.м."])
    end

    it "Quotations #002" do
      text = Segmenter::Text.new(text: "Маленькая девочка бежала и кричала: «Не видали маму?».", language: "ru")
      expect(text.segment).to eq(["Маленькая девочка бежала и кричала: «Не видали маму?»."])
    end

    it "Numbers #003" do
      text = Segmenter::Text.new(text: "Сегодня 27.10.14", language: "ru")
      expect(text.segment).to eq(["Сегодня 27.10.14"])
    end
  end

  context "Golden Rules (Spanish)" do
    it "Question mark to end sentence #001" do
      text = Segmenter::Text.new(text: "¿Cómo está hoy? Espero que muy bien.", language: "es")
      expect(text.segment).to eq(["¿Cómo está hoy?", "Espero que muy bien."])
    end

    it "Exclamation point to end sentence #002" do
      text = Segmenter::Text.new(text: "¡Hola señorita! Espero que muy bien.", language: "es")
      expect(text.segment).to eq(["¡Hola señorita!", "Espero que muy bien."])
    end

    it "Abbreviations #003" do
      text = Segmenter::Text.new(text: "Hola Srta. Ledesma. Buenos días, soy el Lic. Naser Pastoriza, y él es mi padre, el Dr. Naser.", language: "es")
      expect(text.segment).to eq(["Hola Srta. Ledesma.", "Buenos días, soy el Lic. Naser Pastoriza, y él es mi padre, el Dr. Naser."])
    end

    it "Numbers #004" do
      text = Segmenter::Text.new(text: "¡La casa cuesta $170.500.000,00! ¡Muy costosa! Se prevé una disminución del 12.5% para el próximo año.", language: "es")
      expect(text.segment).to eq(["¡La casa cuesta $170.500.000,00!", "¡Muy costosa!", "Se prevé una disminución del 12.5% para el próximo año."])
    end

    it "Quotations #005" do
      text = Segmenter::Text.new(text: "«Ninguna mente extraordinaria está exenta de un toque de demencia.», dijo Aristóteles.", language: "es")
      expect(text.segment).to eq(["«Ninguna mente extraordinaria está exenta de un toque de demencia.», dijo Aristóteles."])
    end
  end

  context "Golden Rules (Greek)" do
    it "Question mark to end sentence #001" do
      text = Segmenter::Text.new(text: "Με συγχωρείτε· πού είναι οι τουαλέτες; Τις Κυριακές δε δούλευε κανένας. το κόστος του σπιτιού ήταν £260.950,00.", language: "el")
      expect(text.segment).to eq(["Με συγχωρείτε· πού είναι οι τουαλέτες;", "Τις Κυριακές δε δούλευε κανένας.", "το κόστος του σπιτιού ήταν £260.950,00."])
    end
  end

  context "Golden Rules (Hindi)" do
    it "Full stop #001" do
      text = Segmenter::Text.new(text: "सच्चाई यह है कि इसे कोई नहीं जानता। हो सकता है यह फ़्रेन्को के खिलाफ़ कोई विद्रोह रहा हो, या फिर बेकाबू हो गया कोई आनंदोत्सव।", language: "hi")
      expect(text.segment).to eq(["सच्चाई यह है कि इसे कोई नहीं जानता।", "हो सकता है यह फ़्रेन्को के खिलाफ़ कोई विद्रोह रहा हो, या फिर बेकाबू हो गया कोई आनंदोत्सव।"])
    end
  end

  context "Golden Rules (Armenian)" do
    it "Sentence ending punctuation #001" do
      text = Segmenter::Text.new(text: "Ի՞նչ ես մտածում: Ոչինչ:", language: "hy")
      expect(text.segment).to eq(["Ի՞նչ ես մտածում:", "Ոչինչ:"])
    end

    it "Ellipsis #002" do
      text = Segmenter::Text.new(text: "Ապրիլի 24-ին սկսեց անձրևել...Այդպես էի գիտեի:", language: "hy")
      expect(text.segment).to eq(["Ապրիլի 24-ին սկսեց անձրևել...Այդպես էի գիտեի:"])
    end

    it "Period is not a sentence boundary #003" do
      text = Segmenter::Text.new(text: "Այսպիսով` մոտենում ենք ավարտին: Տրամաբանությյունը հետևյալն է. պարզություն և աշխատանք:", language: "hy")
      expect(text.segment).to eq(["Այսպիսով` մոտենում ենք ավարտին:", "Տրամաբանությյունը հետևյալն է. պարզություն և աշխատանք:"])
    end
  end

  context "Golden Rules (Burmese)" do
    it "Sentence ending punctuation #001" do
      text = Segmenter::Text.new(text: "ခင္ဗ်ားနာမည္ဘယ္လိုေခၚလဲ။၇ွင္ေနေကာင္းလား။", language: 'my')
      expect(text.segment).to eq(["ခင္ဗ်ားနာမည္ဘယ္လိုေခၚလဲ။", "၇ွင္ေနေကာင္းလား။"])
    end
  end

  context "Golden Rules (Amharic)" do
    it "Sentence ending punctuation #001" do
      text = Segmenter::Text.new(text: "እንደምን አለህ፧መልካም ቀን ይሁንልህ።እባክሽ ያልሽዉን ድገሚልኝ።", language: 'am')
      expect(text.segment).to eq(["እንደምን አለህ፧", "መልካም ቀን ይሁንልህ።", "እባክሽ ያልሽዉን ድገሚልኝ።"])
    end
  end

  context "Golden Rules (Persian)" do
    it "Sentence ending punctuation #001" do
      text = Segmenter::Text.new(text: "خوشبختم، آقای رضا. شما کجایی هستید؟ من از تهران هستم.", language: 'fa')
      expect(text.segment).to eq(["خوشبختم، آقای رضا.", "شما کجایی هستید؟", "من از تهران هستم."])
    end
  end

  context "Golden Rules (Urdu)" do
    it "Sentence ending punctuation #001" do
      text = Segmenter::Text.new(text: "کیا حال ہے؟ ميرا نام ___ ەے۔ میں حالا تاوان دےدوں؟", language: 'ur')
      expect(text.segment).to eq(["کیا حال ہے؟", "ميرا نام ___ ەے۔", "میں حالا تاوان دےدوں؟"])
    end
  end
end