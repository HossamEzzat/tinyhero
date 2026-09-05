import '../models/models.dart';

class FoodDatabase {
  static const List<FoodItem> all = [
    // 🥦 Vegetables
    FoodItem(name: 'خيار', category: FoodCategory.vegetables, carbPerGram: 0.04),
    FoodItem(name: 'طماطم', category: FoodCategory.vegetables, carbPerGram: 0.04),
    FoodItem(name: 'جزر', category: FoodCategory.vegetables, carbPerGram: 0.10),
    FoodItem(name: 'بطاطس', category: FoodCategory.vegetables, carbPerGram: 0.20),
    FoodItem(name: 'بطاطا', category: FoodCategory.vegetables, carbPerGram: 0.24),
    FoodItem(name: 'بصل', category: FoodCategory.vegetables, carbPerGram: 0.09),
    FoodItem(name: 'فلفل رومي', category: FoodCategory.vegetables, carbPerGram: 0.06),
    FoodItem(name: 'بروكلي', category: FoodCategory.vegetables, carbPerGram: 0.07),
    FoodItem(name: 'قرنبيط', category: FoodCategory.vegetables, carbPerGram: 0.05),
    FoodItem(name: 'كوسة', category: FoodCategory.vegetables, carbPerGram: 0.03),
    FoodItem(name: 'باذنجان', category: FoodCategory.vegetables, carbPerGram: 0.06),
    FoodItem(name: 'بسلة', category: FoodCategory.vegetables, carbPerGram: 0.14),
    FoodItem(name: 'ذرة', category: FoodCategory.vegetables, carbPerGram: 0.21),
    FoodItem(name: 'فاصوليا خضراء', category: FoodCategory.vegetables, carbPerGram: 0.07),
    FoodItem(name: 'سبانخ', category: FoodCategory.vegetables, carbPerGram: 0.04),
    FoodItem(name: 'ملوخية', category: FoodCategory.vegetables, carbPerGram: 0.08),
    FoodItem(name: 'خس', category: FoodCategory.vegetables, carbPerGram: 0.03),
    FoodItem(name: 'فول حراتي (الأخضر)', category: FoodCategory.vegetables, carbPerGram: 0.18),
    FoodItem(name: 'كرنب', category: FoodCategory.vegetables, carbPerGram: 0.06),

    // 🍎 Fruits
    FoodItem(name: 'تفاح', category: FoodCategory.fruits, carbPerGram: 0.14),
    FoodItem(name: 'موز', category: FoodCategory.fruits, carbPerGram: 0.23),
    FoodItem(name: 'برتقال', category: FoodCategory.fruits, carbPerGram: 0.12),
    FoodItem(name: 'مانجو', category: FoodCategory.fruits, carbPerGram: 0.15),
    FoodItem(name: 'عنب', category: FoodCategory.fruits, carbPerGram: 0.18),
    FoodItem(name: 'بطيخ', category: FoodCategory.fruits, carbPerGram: 0.08),
    FoodItem(name: 'شمام', category: FoodCategory.fruits, carbPerGram: 0.08),
    FoodItem(name: 'كمثرى', category: FoodCategory.fruits, carbPerGram: 0.15),
    FoodItem(name: 'خوخ', category: FoodCategory.fruits, carbPerGram: 0.10),
    FoodItem(name: 'كيوي', category: FoodCategory.fruits, carbPerGram: 0.15),
    FoodItem(name: 'أناناس', category: FoodCategory.fruits, carbPerGram: 0.13),
    FoodItem(name: 'فراولة', category: FoodCategory.fruits, carbPerGram: 0.08),
    FoodItem(name: 'توت', category: FoodCategory.fruits, carbPerGram: 0.10),
    FoodItem(name: 'تمر', category: FoodCategory.fruits, carbPerGram: 0.75),
    FoodItem(name: 'أفوكادو', category: FoodCategory.fruits, carbPerGram: 0.09),
    FoodItem(name: 'برقوق', category: FoodCategory.fruits, carbPerGram: 0.11),
    FoodItem(name: 'تين شوكي', category: FoodCategory.fruits, carbPerGram: 0.09),
    FoodItem(name: 'تين برشومي', category: FoodCategory.fruits, carbPerGram: 0.19),
    FoodItem(name: 'حبوب الرمان', category: FoodCategory.fruits, carbPerGram: 0.19),
    FoodItem(name: 'قرع عسلي', category: FoodCategory.fruits, carbPerGram: 0.05),
    FoodItem(name: 'كاكا', category: FoodCategory.fruits, carbPerGram: 0.20),
    FoodItem(name: 'كريز', category: FoodCategory.fruits, carbPerGram: 0.16),
    FoodItem(name: 'جوافة', category: FoodCategory.fruits, carbPerGram: 0.14),
    FoodItem(name: 'مشمش', category: FoodCategory.fruits, carbPerGram: 0.12),
    FoodItem(name: 'يوسفي', category: FoodCategory.fruits, carbPerGram: 0.13),
    FoodItem(name: 'حرنكش', category: FoodCategory.fruits, carbPerGram: 0.11),

    // 🥛 Dairy
    FoodItem(name: 'لبن كامل الدسم', category: FoodCategory.dairy, carbPerGram: 0.05),
    FoodItem(name: 'لبن قليل الدسم', category: FoodCategory.dairy, carbPerGram: 0.05),
    FoodItem(name: 'زبادي طبيعي', category: FoodCategory.dairy, carbPerGram: 0.05),
    FoodItem(name: 'زبادي يوناني', category: FoodCategory.dairy, carbPerGram: 0.04),
    FoodItem(name: 'جبنة قريش', category: FoodCategory.dairy, carbPerGram: 0.03),
    FoodItem(name: 'جبنة رومي', category: FoodCategory.dairy, carbPerGram: 0.00),
    FoodItem(name: 'لبنة', category: FoodCategory.dairy, carbPerGram: 0.05),
    FoodItem(name: 'جبنة فلامنك', category: FoodCategory.dairy, carbPerGram: 0.00),
    FoodItem(name: 'جبنة مثلثات (النستو)', category: FoodCategory.dairy, carbPerGram: 0.04),
    FoodItem(name: 'جبنة حلوم', category: FoodCategory.dairy, carbPerGram: 0.02),
    FoodItem(name: 'جبنة موتزريلا', category: FoodCategory.dairy, carbPerGram: 0.04),
    FoodItem(name: 'جبنة قديمة', category: FoodCategory.dairy, carbPerGram: 0.02),

    // 🍲 Main meals (وجبات رئيسية)
    FoodItem(name: 'كشري', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'أرز أبيض مطبوخ', category: FoodCategory.mainMeals, carbPerGram: 0.28),
    FoodItem(name: 'أرز بالشعرية', category: FoodCategory.mainMeals, carbPerGram: 0.30),
    FoodItem(name: 'مكرونة بالصلصة', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'مكرونة بالبشاميل', category: FoodCategory.mainMeals, carbPerGram: 0.18),
    FoodItem(name: 'محشي ورق عنب', category: FoodCategory.mainMeals, carbPerGram: 0.18),
    FoodItem(name: 'محشي كوسة', category: FoodCategory.mainMeals, carbPerGram: 0.10),
    FoodItem(name: 'محشي باذنجان', category: FoodCategory.mainMeals, carbPerGram: 0.12),
    FoodItem(name: 'محشي فلفل', category: FoodCategory.mainMeals, carbPerGram: 0.11),
    FoodItem(name: 'كرنب محشي', category: FoodCategory.mainMeals, carbPerGram: 0.15),
    FoodItem(name: 'ملوخية مطبوخة', category: FoodCategory.mainMeals, carbPerGram: 0.07),
    FoodItem(name: 'فول مدمس', category: FoodCategory.mainMeals, carbPerGram: 0.19),
    FoodItem(name: 'طعمية (فلافل)', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'بطاطس مسلوقة', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'بطاطس مقلية', category: FoodCategory.mainMeals, carbPerGram: 0.35),
    FoodItem(name: 'بطاطس بيوريه', category: FoodCategory.mainMeals, carbPerGram: 0.18),
    FoodItem(name: 'صينية البطاطس في الفرن', category: FoodCategory.mainMeals, carbPerGram: 0.10),
    FoodItem(name: 'بطاطس محشية لحم مفروم', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'ساندوتش بطاطس سوري', category: FoodCategory.mainMeals, carbPerGram: 0.32),
    FoodItem(name: 'عدس أصفر (شوربة)', category: FoodCategory.mainMeals, carbPerGram: 0.13),
    FoodItem(name: 'كشري أصفر (عدس)', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'عدس بجبة مطبوخ', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'بامية بالصلصة', category: FoodCategory.mainMeals, carbPerGram: 0.08),
    FoodItem(name: 'بامية ويكا', category: FoodCategory.mainMeals, carbPerGram: 0.07),
    FoodItem(name: 'بسلة بالجزر', category: FoodCategory.mainMeals, carbPerGram: 0.13),
    FoodItem(name: 'سبانخ مطبوخة', category: FoodCategory.mainMeals, carbPerGram: 0.05),
    FoodItem(name: 'كوسة مطبوخة', category: FoodCategory.mainMeals, carbPerGram: 0.04),
    FoodItem(name: 'فاصوليا خضراء مطبوخة', category: FoodCategory.mainMeals, carbPerGram: 0.07),
    FoodItem(name: 'مسقعة', category: FoodCategory.mainMeals, carbPerGram: 0.09),
    FoodItem(name: 'ممبار', category: FoodCategory.mainMeals, carbPerGram: 0.21),
    FoodItem(name: 'فتة أرز', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'فتة شاورما', category: FoodCategory.mainMeals, carbPerGram: 0.22),
    FoodItem(name: 'رقاق باللحمة', category: FoodCategory.mainMeals, carbPerGram: 0.45),
    FoodItem(name: 'سمبوسة بالجبنة', category: FoodCategory.mainMeals, carbPerGram: 0.40),
    FoodItem(name: 'سمبوسة باللحمة', category: FoodCategory.mainMeals, carbPerGram: 0.30),
    FoodItem(name: 'حمام محشي أرز', category: FoodCategory.mainMeals, carbPerGram: 0.15),
    FoodItem(name: 'حمام محشي فريك', category: FoodCategory.mainMeals, carbPerGram: 0.17),
    FoodItem(name: 'فريك مطبوخ', category: FoodCategory.mainMeals, carbPerGram: 0.22),
    FoodItem(name: 'فاصوليا بيضاء', category: FoodCategory.mainMeals, carbPerGram: 0.23),
    FoodItem(name: 'اللوبيا', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'فاصوليا حمراء', category: FoodCategory.mainMeals, carbPerGram: 0.23),
    FoodItem(name: 'بيتزا', category: FoodCategory.mainMeals, carbPerGram: 0.33),
    FoodItem(name: 'حواوشي', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'جلاش باللحم', category: FoodCategory.mainMeals, carbPerGram: 0.35),
    FoodItem(name: 'جلاش بالجبنة', category: FoodCategory.mainMeals, carbPerGram: 0.38),
    FoodItem(name: 'البرجر (ساندوتش برجر)', category: FoodCategory.mainMeals, carbPerGram: 0.22),
    FoodItem(name: 'كريب', category: FoodCategory.mainMeals, carbPerGram: 0.28),
    FoodItem(name: 'شكشوكة', category: FoodCategory.mainMeals, carbPerGram: 0.05),
    FoodItem(name: 'بصارة', category: FoodCategory.mainMeals, carbPerGram: 0.15),
    FoodItem(name: 'كفتة أرز', category: FoodCategory.mainMeals, carbPerGram: 0.12),
    FoodItem(name: 'شوربة لسان العصفور', category: FoodCategory.mainMeals, carbPerGram: 0.10),
    FoodItem(name: 'ساندوتش شاورما سوري (دجاج)', category: FoodCategory.mainMeals, carbPerGram: 0.24),
    FoodItem(name: 'كبيبة', category: FoodCategory.mainMeals, carbPerGram: 0.20),
    FoodItem(name: 'كورن فليكس', category: FoodCategory.mainMeals, carbPerGram: 0.84),
    FoodItem(name: 'فراخ بانيه', category: FoodCategory.mainMeals, carbPerGram: 0.12),
    FoodItem(name: 'باتيه بالجبنة', category: FoodCategory.mainMeals, carbPerGram: 0.45),
    FoodItem(name: 'ساندوتش كبدة إسكندراني', category: FoodCategory.mainMeals, carbPerGram: 0.25),
    FoodItem(name: 'منقوشة زعتر', category: FoodCategory.mainMeals, carbPerGram: 0.45),
    FoodItem(name: 'منقوشة جبنة', category: FoodCategory.mainMeals, carbPerGram: 0.42),

    // 🍞 Bakery
    FoodItem(name: 'عيش بلدي', category: FoodCategory.bakery, carbPerGram: 0.55),
    FoodItem(name: 'عيش شامي', category: FoodCategory.bakery, carbPerGram: 0.56),
    FoodItem(name: 'توست أبيض', category: FoodCategory.bakery, carbPerGram: 0.49),
    FoodItem(name: 'توست أسمر', category: FoodCategory.bakery, carbPerGram: 0.43),
    FoodItem(name: 'خبز فينو', category: FoodCategory.bakery, carbPerGram: 0.53),
    FoodItem(name: 'خبز برجر', category: FoodCategory.bakery, carbPerGram: 0.51),
    FoodItem(name: 'خبز هوت دوج', category: FoodCategory.bakery, carbPerGram: 0.50),
    FoodItem(name: 'خبز باجيت (فرنسي)', category: FoodCategory.bakery, carbPerGram: 0.57),
    FoodItem(name: 'خبز سن', category: FoodCategory.bakery, carbPerGram: 0.44),
    FoodItem(name: 'خبز نخالة', category: FoodCategory.bakery, carbPerGram: 0.42),
    FoodItem(name: 'خبز شوفان', category: FoodCategory.bakery, carbPerGram: 0.43),
    FoodItem(name: 'خبز الجاودار', category: FoodCategory.bakery, carbPerGram: 0.48),
    FoodItem(name: 'تورتيلا', category: FoodCategory.bakery, carbPerGram: 0.48),
    FoodItem(name: 'كرواسون سادة', category: FoodCategory.bakery, carbPerGram: 0.45),
    FoodItem(name: 'كرواسون جبنة', category: FoodCategory.bakery, carbPerGram: 0.43),
    FoodItem(name: 'كرواسون شوكولاتة', category: FoodCategory.bakery, carbPerGram: 0.47),
    FoodItem(name: 'باتيه جبنة', category: FoodCategory.bakery, carbPerGram: 0.40),
    FoodItem(name: 'باتيه سجق', category: FoodCategory.bakery, carbPerGram: 0.39),
    FoodItem(name: 'باتيه شوكولاتة', category: FoodCategory.bakery, carbPerGram: 0.46),
    FoodItem(name: 'مولتو شوكولاتة', category: FoodCategory.bakery, carbPerGram: 0.53),
    FoodItem(name: 'مولتو فراولة', category: FoodCategory.bakery, carbPerGram: 0.54),
    FoodItem(name: 'مولتو كاسترد', category: FoodCategory.bakery, carbPerGram: 0.52),
    FoodItem(name: 'دونات (مخبوزات)', category: FoodCategory.bakery, carbPerGram: 0.50),
    FoodItem(name: 'مافن سادة', category: FoodCategory.bakery, carbPerGram: 0.52),
    FoodItem(name: 'مافن شوكولاتة', category: FoodCategory.bakery, carbPerGram: 0.54),
    FoodItem(name: 'كوكيز', category: FoodCategory.bakery, carbPerGram: 0.68),
    FoodItem(name: 'بسكويت شاي', category: FoodCategory.bakery, carbPerGram: 0.72),
    FoodItem(name: 'بسكويت دايجستف', category: FoodCategory.bakery, carbPerGram: 0.66),
    FoodItem(name: 'بسكويت سادة', category: FoodCategory.bakery, carbPerGram: 0.71),
    FoodItem(name: 'بسكويت بالزبدة', category: FoodCategory.bakery, carbPerGram: 0.67),
    FoodItem(name: 'بسكويت أوريو', category: FoodCategory.bakery, carbPerGram: 0.69),
    FoodItem(name: 'كعك سادة', category: FoodCategory.bakery, carbPerGram: 0.67),
    FoodItem(name: 'غريبة (مخبوزات)', category: FoodCategory.bakery, carbPerGram: 0.56),
    FoodItem(name: 'فايش', category: FoodCategory.bakery, carbPerGram: 0.70),
    FoodItem(name: 'بقسماط', category: FoodCategory.bakery, carbPerGram: 0.72),

    // 🍰 Sweets
    FoodItem(name: 'بسبوسة', category: FoodCategory.sweets, carbPerGram: 0.53),
    FoodItem(name: 'كنافة', category: FoodCategory.sweets, carbPerGram: 0.47),
    FoodItem(name: 'بقلاوة', category: FoodCategory.sweets, carbPerGram: 0.48),
    FoodItem(name: 'أم علي', category: FoodCategory.sweets, carbPerGram: 0.28),
    FoodItem(name: 'أرز باللبن', category: FoodCategory.sweets, carbPerGram: 0.25),
    FoodItem(name: 'مهلبية', category: FoodCategory.sweets, carbPerGram: 0.22),
    FoodItem(name: 'كريم كراميل', category: FoodCategory.sweets, carbPerGram: 0.27),
    FoodItem(name: 'فطير مشلتت', category: FoodCategory.sweets, carbPerGram: 0.50),
    FoodItem(name: 'بلح الشام', category: FoodCategory.sweets, carbPerGram: 0.50),
    FoodItem(name: 'لقمة القاضي (الزلابية)', category: FoodCategory.sweets, carbPerGram: 0.49),
    FoodItem(name: 'مشبك', category: FoodCategory.sweets, carbPerGram: 0.66),
    FoodItem(name: 'أصابع زينب', category: FoodCategory.sweets, carbPerGram: 0.52),
    FoodItem(name: 'قطايف سادة', category: FoodCategory.sweets, carbPerGram: 0.42),
    FoodItem(name: 'قطايف بالمكسرات', category: FoodCategory.sweets, carbPerGram: 0.45),
    FoodItem(name: 'قطايف بالقشطة', category: FoodCategory.sweets, carbPerGram: 0.36),
    FoodItem(name: 'غريبة', category: FoodCategory.sweets, carbPerGram: 0.63),
    FoodItem(name: 'كحك سادة', category: FoodCategory.sweets, carbPerGram: 0.61),
    FoodItem(name: 'كحك بالعجوة', category: FoodCategory.sweets, carbPerGram: 0.58),
    FoodItem(name: 'كحك بالملبن', category: FoodCategory.sweets, carbPerGram: 0.59),
    FoodItem(name: 'بسكويت النشادر', category: FoodCategory.sweets, carbPerGram: 0.68),
    FoodItem(name: 'بيتيفور', category: FoodCategory.sweets, carbPerGram: 0.62),
    FoodItem(name: 'معمول تمر', category: FoodCategory.sweets, carbPerGram: 0.60),
    FoodItem(name: 'معمول فستق', category: FoodCategory.sweets, carbPerGram: 0.52),
    FoodItem(name: 'هريسة', category: FoodCategory.sweets, carbPerGram: 0.54),
    FoodItem(name: 'حلاوة طحينية', category: FoodCategory.sweets, carbPerGram: 0.28),
    FoodItem(name: 'حلاوة شعر', category: FoodCategory.sweets, carbPerGram: 0.44),
    FoodItem(name: 'ملبن', category: FoodCategory.sweets, carbPerGram: 0.76),
    FoodItem(name: 'حمصية', category: FoodCategory.sweets, carbPerGram: 0.69),
    FoodItem(name: 'سمسمية', category: FoodCategory.sweets, carbPerGram: 0.62),
    FoodItem(name: 'فولية', category: FoodCategory.sweets, carbPerGram: 0.43),
    FoodItem(name: 'سودانية', category: FoodCategory.sweets, carbPerGram: 0.29),
    FoodItem(name: 'تمرية', category: FoodCategory.sweets, carbPerGram: 0.67),
    FoodItem(name: 'جاتوه', category: FoodCategory.sweets, carbPerGram: 0.52),
    FoodItem(name: 'كيك فانيليا', category: FoodCategory.sweets, carbPerGram: 0.50),
    FoodItem(name: 'كيك شوكولاتة', category: FoodCategory.sweets, carbPerGram: 0.55),
    FoodItem(name: 'تورتة فانيليا', category: FoodCategory.sweets, carbPerGram: 0.49),
    FoodItem(name: 'تورتة شوكولاتة', category: FoodCategory.sweets, carbPerGram: 0.50),
    FoodItem(name: 'دونات', category: FoodCategory.sweets, carbPerGram: 0.49),
    FoodItem(name: 'كرواسون بالشوكولاتة', category: FoodCategory.sweets, carbPerGram: 0.45),
    FoodItem(name: 'وافل', category: FoodCategory.sweets, carbPerGram: 0.52),
    FoodItem(name: 'بان كيك', category: FoodCategory.sweets, carbPerGram: 0.28),
    FoodItem(name: 'بان كيك نوتيلا', category: FoodCategory.sweets, carbPerGram: 0.35),
    FoodItem(name: 'آيس كريم فانيليا', category: FoodCategory.sweets, carbPerGram: 0.24),
    FoodItem(name: 'آيس كريم شوكولاتة', category: FoodCategory.sweets, carbPerGram: 0.26),
    FoodItem(name: 'جرانولا', category: FoodCategory.sweets, carbPerGram: 0.40),
    FoodItem(name: 'زبدة فول سوداني', category: FoodCategory.sweets, carbPerGram: 0.22),

    // 🍗 Protein / rarely counted
    FoodItem(name: 'دجاج مشوي', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'لحم مشوي', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'سمك مشوي', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'كبدة مشوية', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'بيض مسلوق', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'بيض مقلي', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'بروتينات حيوانية', category: FoodCategory.protein, carbPerGram: 0.00),
    FoodItem(name: 'خضروات أخضر غامق', category: FoodCategory.protein, carbPerGram: 0.00),
  ];

  static List<FoodItem> byCategory(FoodCategory category) =>
      all.where((f) => f.category == category).toList();

  static List<FoodItem> search(String query) {
    final q = query.trim();
    if (q.isEmpty) return all;
    return all.where((f) => f.name.contains(q)).toList();
  }

  static String categoryLabel(FoodCategory c) => switch (c) {
        FoodCategory.vegetables => 'خضروات',
        FoodCategory.fruits => 'فاكهة',
        FoodCategory.dairy => 'ألبان',
        FoodCategory.mainMeals => 'وجبات رئيسية',
        FoodCategory.bakery => 'مخبوزات',
        FoodCategory.sweets => 'حلويات',
        FoodCategory.protein => 'أكلات لا تُحسب',
      };

  static String categoryEmoji(FoodCategory c) => switch (c) {
        FoodCategory.vegetables => '🥦',
        FoodCategory.fruits => '🍎',
        FoodCategory.dairy => '🥛',
        FoodCategory.mainMeals => '🍲',
        FoodCategory.bakery => '🍞',
        FoodCategory.sweets => '🍰',
        FoodCategory.protein => '🍗',
      };

  static String carbLabel(FoodItem item) {
    if (item.carbPerGram <= 0) return 'لا تُحسب';
    return item.carbPerGram.toStringAsFixed(2);
  }
}

class InsulinCalculator {
  /// totalCarbs / carbRatio
  static double unitsFromTotalCarbs(double totalCarbs, double carbRatio) {
    if (carbRatio <= 0) return 0;
    return totalCarbs / carbRatio;
  }

  /// (carbPerGram * grams) / carbRatio
  static double unitsFromFood({
    required double carbPerGram,
    required double grams,
    required double carbRatio,
  }) {
    return unitsFromTotalCarbs(carbPerGram * grams, carbRatio);
  }
}

class SugarHelpers {
  static String statusLabel(SugarStatus s) => switch (s) {
        SugarStatus.low => 'هبوط',
        SugarStatus.normal => 'طبيعي',
        SugarStatus.high => 'مرتفع',
      };

  static String statusEmoji(SugarStatus s) => switch (s) {
        SugarStatus.low => '😟',
        SugarStatus.normal => '😊',
        SugarStatus.high => '😥',
      };
}

const List<String> motivationalMessages = [
  'أنت بطل! كل خطوة صغيرة بتقربك لصحة أفضل 💪',
  'قياس السكر بانتظام بيخلي اليوم أسهل وأأمن 🌟',
  'اشرب مية، وكل كويس، وانت بطل اليوم 🦸',
  'معامل الكارب بيتغير… ومتابعة الدكتور دايمًا أهم 🩺',
  'كل وجبة محسوبة = يوم أنظف وأهدأ ✨',
];
