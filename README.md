# Rutinim

Telefon ve bilgisayarda günlük alışkanlık takibi için statik web uygulaması. GitHub Pages üzerinde yayınlanabilir. Rutinler ve günlük tamamlamalar, giriş yapılana kadar bu tarayıcının yerel deposunda kalır. Günler birbirinden bağımsızdır; tikler sadece seçilen gün için tutulur.

## Yerelde açma

`index.html` dosyasını tarayıcıda açabilir ya da klasörde `python -m http.server 8000` çalıştırıp `http://localhost:8000` adresine gidebilirsin.

## Cihazlar arasında eşitleme (Supabase)

Supabase projesi oluşturuldu ve `supabase-schema.sql` şeması projede çalıştırıldı. `app.js` içinde proje URL'si ve tarayıcıda kullanılabilen `sb_publishable_` anahtarı bulunur. Bu anahtarın GitHub Pages'te görünmesi normaldir; Supabase secret veya service role anahtarını istemci koduna koyma.

GitHub Pages'e yayınladıktan sonra Supabase Dashboard → Authentication → URL Configuration içinde yayın adresini Site URL ve Redirect URLs alanlarına ekle. E-posta doğrulaması açıkken kayıt sonrası gelen doğrulama bağlantısını aç; ardından aynı hesapla diğer cihazda da giriş yap.

Bu klasörü GitHub deposuna koy ve Settings → Pages'ten `main` dalının kökünü yayınla.

Tarayıcı istemcisi yalnızca publishable anahtarı kullanır. Veritabanı erişimi, oturum açmış kullanıcının kendi satırlarıyla sınırlandıran RLS politikalarıyla korunur.

## Hatırlatmalar

Saat eklenmiş rutinler, site bu tarayıcıda açıkken hatırlatılır. İlk aşamada bildirim için tarayıcı/site izni gerekir; kapalıyken bildirim gönderimi statik GitHub Pages tarafından sağlanmaz.
