Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEE1FE469
	for <linux-security-module@vger.kernel.org>; Tue,  4 Mar 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084325; cv=none; b=N//KeyvsebFa00a6RiiMjAmLLkAdMw+gWPfS8h/5+zZZKHynFIzOEp97XznxyHY6jEqRnFW96yH2dR4NxJsu/+oGAh/kgrC1SadLWZupqeny+gxb39epwpnzwgDx6wr5OSmj0Oc9yGbqSr3WyplQ3y9W6bBg41Gwl4XZVs2WmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084325; c=relaxed/simple;
	bh=2QN4c6t4NTMLZfo84yIUSl8a68B1T7HX28jmEa3K2TQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SiVXhzs7h8wT/ZSZQQLF/IeO6KRV703v70MUT+cyptoUMMSGKY7nurfaEXh9qTLVDwKDEEF+55enmR3+3Y8TXHx1iEh/qUNiD+ucUEuKDsjRkQ3yizg593OR6ZkmNGnQCbga5nAuQ8UKrnquSud4HoWlWn81NTgzRnJWsJU2S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K55R1tuo; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K55R1tuo"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so25038495e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741084322; x=1741689122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CgBM9qkXPKsz4E4wlMO9VCpTU9cY6MKXXq6pU54rOXU=;
        b=K55R1tuonZDQuU8sPAcgsuiwDXi4Zc5mvtHHJTMHp7mmzrY1Ia0LXEFgA/Z4eqoqfI
         yH6SWMy7WNJ8MIIrTRIT6RqBCDHqNch9vnyv29KyFE1NOvdpgDfskdk53CkJdhOFAuak
         QIZ6Q+7tYkFoa4jzErQI+aW2ZVNaY6aZICCfMGM+KH8MmSIQw8sfESjUvrwIg7LUPoq6
         xoUPmzr6hWEwvHEvVvOodaG9hRqKbO63jkFLMp6V6XrGraVSSYPuPZ3ohdpNQmI1VkRV
         R6GGBHGc5Cvvj96SyJM4AMBN+aVJy4hN0D2u5rgpbcOpvkzPxKlbeV6EEAfuFkXlZOPu
         zJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084322; x=1741689122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgBM9qkXPKsz4E4wlMO9VCpTU9cY6MKXXq6pU54rOXU=;
        b=JBrBDDK8Dym3T1xLfbjaf3oB+XIins846e34REuK+AbYKuMl/7z8J1QsEp5upWFNty
         j/HnQNmmHIahx9KG+DibxGUvT3y4aXK/hrxdG16MTI3lK5yM88Un8Y8K3hwUB9GtxdGo
         ncDBk6bt/bW4kRxK7LtgAOv4IAhOycJFP4omkkqI2UiiJs4gBiMzmqWnxALEQQQ+X4XI
         j33ycVmFLF3EjSzSAKQSj/JmNyvPkW5DezpW8cnEaskaNxCzIdkrc5zNCmgQvI47gkwk
         tfwSEKAslQ9YJyu44hzDaGk0+NZwLfnfffkdQVX+xA4lDkyt+AVhoD8hLzqJCgaRAcrW
         BjVw==
X-Forwarded-Encrypted: i=1; AJvYcCX5HZB4EITmP4Bqq7qpMrwXXTodOF3WuFh0zVdBu/+/Ghg3Afv3OeaNHXAffJ6Mi0spAyYPtaA8KtfrxTeyiSNM+NmZ2ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsC3iKrjXc4REl4Hkd25HPWRYqrXROsAHU5qqyH0gP1f2anA5
	qGQPz39uu1qriyPodFLaYO4vholc6rQ8Cs/zvBOTw7noNOFWLwIJ+EJmGYJAWalyugY6YwtT2Gr
	p3fhiKSloYT5IlQ==
X-Google-Smtp-Source: AGHT+IHhnkbrdCEb0Dq9dBlFWcgEAlaF3SWEtL4WwW/UfW9TbgpU0Jmo6dviPOgNSpapJjyGppCqbmtXhTCpUF4=
X-Received: from wmrn9.prod.google.com ([2002:a05:600c:5009:b0:43b:c205:3a80])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d2:b0:439:9f97:7d67 with SMTP id 5b1f17b1804b1-43ba6704614mr161034505e9.16.1741084322399;
 Tue, 04 Mar 2025 02:32:02 -0800 (PST)
Date: Tue, 04 Mar 2025 10:31:55 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJrWxmcC/x2M3QpAQBQGX0Xn2tZaf+VV5GKtD6eEzhFK3t3ma
 pqLmYcUwlBqkocEJytva5QsTSjMfp1geIhOzrrS5rYwihCO2wiuTYaIBV5h4CofCqCG7Sm2u2D k+/+23ft+yWVU+GcAAAA=
X-Change-Id: 20250304-secctx-reword-release-e26ac4ee7e0b
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2QN4c6t4NTMLZfo84yIUSl8a68B1T7HX28jmEa3K2TQ=;
 b=owEBbAKT/ZANAwAKAQRYvu5YxjlGAcsmYgBnxtafko7OGAXd/t7elbNMyK4uxuHQQNW0bF0+g
 nsUQs3Bn/OJAjIEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bWnwAKCRAEWL7uWMY5
 Rk4jD/dSV7WTYYlnYfVe3c6B0oR98nYlDdQoBdHNQ2vx0mm7svyvl/V5f34wg3Ii6WhooeIl+Q+
 7rlJICSPkyc5WphLaimQq7j0pvyH1/DZrBGPE/8usHQa1yWgmOG5z2zywauEi2Q0pQijOvgrj40
 uU0cpDJUBSdcVutmI5dsq5MYzvtaZrRibRrnB754JEUSCVLC2H5YpdhNATk2Q46GoGZGASR18It
 DKxVJgKR4K25rktXEdYk1mN4l2OwN0e25Zu3ro7K8ROBh095CXdJXMbuL7VSAfnuoLqkb0aKHES
 7YYY8cyUvB3V0e5g3UifchYEXc2LyXvhnTZnTJjTofhxQHk3RQqDqdiSFcJmLM75aM3JOSW14Lu
 LxawEUmB3NDPE8NGsfFfLcQJ6cWF3hZb4cybxvuPFUppCZYmlMVDhouLt7lICbS+2vIpQ9Vwi0v
 7r53cq38ZWZLGs32XDU4vSKVg3xepNIVZgO4WlF29jeLT2T2dsd3N0EWVW1mwn67CuH/Tdi0BJO
 dvN+8/Oe470vPjW0scABmAxmN5Dyzgr3WDKm+8ma0Q2qQ2PAl6DtqyI6wkq872+QAgDZ/XkYHg4
 DmDIk/H+sumfeYHbiviUqFKbWDoa9o43gT1gZ/ICJKBrIHjlduflMhms67ebfZpv8FNpShxgCiy vROkNIl7GiI+3
X-Mailer: b4 0.14.2
Message-ID: <20250304-secctx-reword-release-v1-1-e8e9a7ff85ba@google.com>
Subject: [PATCH] lsm: rust: reword "destroy" -> "release" in SecurityCtx
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

What happens inside the individual LSMs for a given LSM hook can vary
quite a bit, so it is best to use the terminology "release" instead of
"destroy" or "free".

Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This patch is based on top of:
https://lore.kernel.org/all/20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com/
---
 rust/kernel/security.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 24321105052648e150f2875bcfa5ef29f4249516..0c63e9e7e564b7d9d85865e5415dd0464e9a9098 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -16,7 +16,7 @@
 /// # Invariants
 ///
 /// The `ctx` field corresponds to a valid security context as returned by a successful call to
-/// `security_secid_to_secctx`, that has not yet been destroyed by `security_release_secctx`.
+/// `security_secid_to_secctx`, that has not yet been released by `security_release_secctx`.
 pub struct SecurityCtx {
     ctx: bindings::lsm_context,
 }
@@ -67,9 +67,8 @@ pub fn as_bytes(&self) -> &[u8] {
 impl Drop for SecurityCtx {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: By the invariant of `Self`, this frees a context that came from a successful
-        // call to `security_secid_to_secctx` and has not yet been destroyed by
-        // `security_release_secctx`.
+        // SAFETY: By the invariant of `Self`, this releases an lsm context that came from a
+        // successful call to `security_secid_to_secctx` and has not yet been released.
         unsafe { bindings::security_release_secctx(&mut self.ctx) };
     }
 }

---
base-commit: 93f60f16db02f7b52985338f37679095231b6383
change-id: 20250304-secctx-reword-release-e26ac4ee7e0b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

