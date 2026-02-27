Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C48394492
	for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188416; cv=none; b=j+0K3xg1krwg1iCqwMvi9RTCmd4qI8ZXJTWF+xSYQKgeYY2xywStovPfk9FgXpdMjlwSg2mhraol/s97NSDCs4jQxEfphHZnKw3zmKgdRfWbNCBCJWv5N75Q2EyyAWoIa3OjAtzyGGngjs3i+oqFwHHGS7uYcVcWlQOvRnMawGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188416; c=relaxed/simple;
	bh=UnWM41+lEiRQDz3Ufvniytt8do6i2ZFs6OcNl+aYnW4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aWINWaXFy2PNkbvA6bTEihh1zeJfpijT5DTo8sVBgK8tUvibqa1TZv9RO+hZOQPjSBKbWdJyPZlAL7RLwdSUVqQVhlfO5puY1dBolKb/VHVbuna43ZYjxA573wLYhAqboqeNMXzwvsd8/LYEC91oEvzlxAMWWM0motgcnIMGA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKs2otbp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKs2otbp"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso27634475e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 02:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772188412; x=1772793212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB7zr9OXRdT4+Mhv7MmxTzoYbehrlxvfpSfSo0hGPIk=;
        b=BKs2otbpQigZ1aesfczMz+t9yaQwMqZbWQYokT56klNAbh8ssTtfLgcY1gTl79nWjc
         M4NiYFcbVGG62/cxFFIM3kH+p30FpyeCVF6lkh8EkgXCdOf4ikBXWbr2fFzukSV2Qxjk
         4+zCty7BNXsB9wY+njUNfgKQmd1VgVgW+cZo82kzi8Rcn8AEizBpfCv+Jx+j1XxR41wI
         qjoUPLwdNNtZvdvvHMgDwFFH/UpKuvc5GiSm5zTTtLfjjhtVyXpb1SKeJp0jN/7OwpDM
         3gzh2chhQRgkdUZ9Zszm5hKrMFNC1gUYdEbo9Zpa3j1zCNhWxhxScqnJa5FDQa5di5HG
         +j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188412; x=1772793212;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB7zr9OXRdT4+Mhv7MmxTzoYbehrlxvfpSfSo0hGPIk=;
        b=EG4y/p468RZKLK8bdroi/SSWHk0oKrIQAOQFrXpIx7MGkzp9FdqbQGs+uKtRWz5DbM
         TMRQsuvs05HVgQPXg1s6s8nFgFB/JOPD8fu96OEj2R2Mmh2QRx/K82TzVdwNiWLP8U65
         UKr07pqnW2VFnMQFdSCrvN5mkpJt1YlcIdS9zRcESdZ9JUcJHIyJu/fE9qyYCBzTOxzF
         Sp2iG2O96PZkYNUu6DP9iDSbPfNVU1ZOrPo8x+1YuPdhz6BW1YcvzKYIO5iFyGdq/5wF
         v5NNXPdJT40v+vAlwwjjZ295aEOSs2NUuHswpydSdNYkbVZu9ibwD8HGIOtQDRM40DsO
         8CJA==
X-Forwarded-Encrypted: i=1; AJvYcCX1UNKbBEPzUKT95ojonnXaaZ4lmm5yiy7SKjHIdm2TUD7rD42kJlTN5h8lMyZq2x6CJgGwslADi02QCttDncoeEwiigsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsA9viyxYTLcNK68RJz53nUp17FJYLdmzEm8hWVm7Qc0BU0an
	MQZ2IHlVJ+Wbb6sLcL+VWwM5s0ds20aP5jn1Q0DqFEojm2Wah6aHFSKPUrXHz4Xah1qWxUBUO+6
	qJgGM6SfU4ypGF6HzzA==
X-Received: from wmbdn10.prod.google.com ([2002:a05:600c:654a:b0:47a:9289:c5d8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d2:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-483c9b9712bmr27822335e9.6.1772188412050;
 Fri, 27 Feb 2026 02:33:32 -0800 (PST)
Date: Fri, 27 Feb 2026 10:33:24 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPNyoWkC/3VPu3KDMBD8FUZ1LpFkTIAq/5FxIcEaaxIh+yQYe
 zz8ewQ0KZJy925fTxHBDlG0xVMwZhddGDPQL4XoLmYcQK7PWGipK6lVQwwfZlAy8YswuZ5Ug9J
 KaQELkWVXxtndN8vP044Ztyk7p50U1kRQF7x3qS2ma0wM49+8iQksfgfnHnusJp5iojXurOzBl
 MeulnXZzurv/wNZN/bgTWF0iR7HfDH1qlhLXVxMgR/b7Eytrf5fOCtS1MhSVrLWFeT7xxDC8I3 XvEGclmX5AWTjr/ZGAQAA
X-Change-Id: 20260219-remove-task-euid-19e4b00beebe
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6248; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=w79zp6DVp0pZUXbCI1PNbHh+3DIMAxbadWfMegP7gpc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpoXL2Pro2XYhlF6XgypTT47gGmW0KIFWKiTQn4
 ja5cPmRliaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaFy9gAKCRAEWL7uWMY5
 Rp1EEACVvUFXZqNTj/F7/aY/SAGN9dOtArjEhfLg6zcA1f1X30NQre+Zq7272cf04f9Z4qw3aRS
 f2GGEDtgUgb6G4PiqwVvqwlOIMW8sryWPiOvXAWS0H1FMgY1wGOdua9GkYiqaoWuVQQejzDgb7I
 NsaLxW53jNY7/h6jMmat9O63QhD9oSZPWXU7y2wH5W12F81oS+B0M34Gu5b/VziTYwHwlzyatt6
 1qftZp54U8u5yHTOYdhBNh0s1kpPKFybK7/XDBP7X2+7o4KFWJ7kLlKCiCWtxHXrk32wuHKMDEr
 YfOWC5b4Ao9LSQ1uAbcwPxmVV+jO36iDyJkU8i4K8nS0NWHv9NwmM3D7Bi3m3bl+zE2oqHyGhvi
 RCwGV8MkKFxzOjyy7Z9nFZ2T0cGYUs63NyauOXZjujc6hgc4zZ0TerzT5G1IH0j9pMnzMWyXSW7
 dVGrst6P5hjUqFJ9Ko5sakN3+1LVtNjFUSkn17Rub/8VCivN3uK84IqJFRIem4185OCzsU8aqTo
 qd3eMhMm0k2lMCi4SfH4d0gaEDURTOeXDyjgdumqdGWUBvpQ89ZlUErq7r+PoYRNnU6yFL2aDZD
 Y4GdwoKFFk6u5gempkoeVIzTjAkmFNVbm/A8BYjm3aVGtCjx8oWlwGhjTaeqBgy1BIwRJrU4R+N l56SIFQpFqf7kiQ==
X-Mailer: b4 0.14.3
Message-ID: <20260227-remove-task-euid-v2-1-9a9c80a82eb6@google.com>
Subject: [PATCH v2] cred: delete task_euid()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

task_euid() is a very weird operation. You can see how weird it is by
grepping for task_euid() - binder is its only user. task_euid() obtains
the objective effective UID - it looks at the credentials of the task
for purposes of acting on it as an object, but then accesses the
effective UID (which the credentials.7 man page describes as "[...] used
by the kernel to determine the permissions that the process will have
when accessing shared resources [...]").

Since usage in Binder has now been removed, get rid of the resulting
dead code.

Changes to the zh_CN translation was carried out with the help of
Gemini and Google Translate.

Suggested-by: Jann Horn <jannh@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Depends on these two changes:
https://lore.kernel.org/all/20260212-rust-uid-v1-1-deff4214c766@google.com/=
   (not picked up)
https://lore.kernel.org/all/20260213-binder-uid-v1-0-7b795ae05523@google.co=
m/ (in char-misc-testing)
---
Changes in v2:
- Update translation as per Alex Shi.
- Pick up Reviewed-by Gary.
- Update commit title to use cred: prefix.
- Link to v1: https://lore.kernel.org/r/20260219-remove-task-euid-v1-1-9040=
60826e07@google.com
---
 Documentation/security/credentials.rst                    |  6 ++----
 Documentation/translations/zh_CN/security/credentials.rst |  4 +---
 include/linux/cred.h                                      |  1 -
 rust/helpers/task.c                                       |  5 -----
 rust/kernel/task.rs                                       | 10 ----------
 5 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/securit=
y/credentials.rst
index d0191c8b8060..81d3b5737d85 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -393,16 +393,14 @@ the credentials so obtained when they're finished wit=
h.
    The result of ``__task_cred()`` should not be passed directly to
    ``get_cred()`` as this may race with ``commit_cred()``.
=20
-There are a couple of convenience functions to access bits of another task=
's
-credentials, hiding the RCU magic from the caller::
+There is a convenience function to access bits of another task's credentia=
ls,
+hiding the RCU magic from the caller::
=20
 	uid_t task_uid(task)		Task's real UID
-	uid_t task_euid(task)		Task's effective UID
=20
 If the caller is holding the RCU read lock at the time anyway, then::
=20
 	__task_cred(task)->uid
-	__task_cred(task)->euid
=20
 should be used instead.  Similarly, if multiple aspects of a task's creden=
tials
 need to be accessed, RCU read lock should be used, ``__task_cred()`` calle=
d,
diff --git a/Documentation/translations/zh_CN/security/credentials.rst b/Do=
cumentation/translations/zh_CN/security/credentials.rst
index 88fcd9152ffe..20c8696f8198 100644
--- a/Documentation/translations/zh_CN/security/credentials.rst
+++ b/Documentation/translations/zh_CN/security/credentials.rst
@@ -337,15 +337,13 @@ const=E6=8C=87=E9=92=88=E4=B8=8A=E6=93=8D=E4=BD=9C=EF=
=BC=8C=E5=9B=A0=E6=AD=A4=E4=B8=8D=E9=9C=80=E8=A6=81=E8=BF=9B=E8=A1=8C=E7=B1=
=BB=E5=9E=8B=E8=BD=AC=E6=8D=A2=EF=BC=8C=E4=BD=86=E9=9C=80=E8=A6=81=E4=B8=B4=
=E6=97=B6=E6=94=BE=E5=BC=83
    ``__task_cred()`` =E7=9A=84=E7=BB=93=E6=9E=9C=E4=B8=8D=E5=BA=94=E7=9B=
=B4=E6=8E=A5=E4=BC=A0=E9=80=92=E7=BB=99 ``get_cred()`` =EF=BC=8C
    =E5=9B=A0=E4=B8=BA=E8=BF=99=E5=8F=AF=E8=83=BD=E4=B8=8E ``commit_cred()`=
` =E5=8F=91=E7=94=9F=E7=AB=9E=E4=BA=89=E6=9D=A1=E4=BB=B6=E3=80=82
=20
-=E8=BF=98=E6=9C=89=E4=B8=80=E4=BA=9B=E6=96=B9=E4=BE=BF=E7=9A=84=E5=87=BD=
=E6=95=B0=E5=8F=AF=E4=BB=A5=E8=AE=BF=E9=97=AE=E5=8F=A6=E4=B8=80=E4=B8=AA=E4=
=BB=BB=E5=8A=A1=E5=87=AD=E6=8D=AE=E7=9A=84=E7=89=B9=E5=AE=9A=E9=83=A8=E5=88=
=86=EF=BC=8C=E5=B0=86RCU=E6=93=8D=E4=BD=9C=E5=AF=B9=E8=B0=83=E7=94=A8=E6=96=
=B9=E9=9A=90=E8=97=8F=E8=B5=B7=E6=9D=A5::
+=E6=9C=89=E4=B8=80=E4=B8=AA=E6=96=B9=E4=BE=BF=E7=9A=84=E5=87=BD=E6=95=B0=
=E5=8F=AF=E7=94=A8=E4=BA=8E=E8=AE=BF=E9=97=AE=E5=8F=A6=E4=B8=80=E4=B8=AA=E4=
=BB=BB=E5=8A=A1=E5=87=AD=E6=8D=AE=E7=9A=84=E7=89=B9=E5=AE=9A=E9=83=A8=E5=88=
=86=EF=BC=8C=E4=BB=8E=E8=80=8C=E5=AF=B9=E8=B0=83=E7=94=A8=E6=96=B9=E9=9A=90=
=E8=97=8FRCU=E6=9C=BA=E5=88=B6::
=20
 	uid_t task_uid(task)		Task's real UID
-	uid_t task_euid(task)		Task's effective UID
=20
 =E5=A6=82=E6=9E=9C=E8=B0=83=E7=94=A8=E6=96=B9=E5=9C=A8=E6=AD=A4=E6=97=B6=
=E5=B7=B2=E7=BB=8F=E6=8C=81=E6=9C=89RCU=E8=AF=BB=E9=94=81=EF=BC=8C=E5=88=99=
=E5=BA=94=E4=BD=BF=E7=94=A8::
=20
 	__task_cred(task)->uid
-	__task_cred(task)->euid
=20
 =E7=B1=BB=E4=BC=BC=E5=9C=B0=EF=BC=8C=E5=A6=82=E6=9E=9C=E9=9C=80=E8=A6=81=
=E8=AE=BF=E9=97=AE=E4=BB=BB=E5=8A=A1=E5=87=AD=E6=8D=AE=E7=9A=84=E5=A4=9A=E4=
=B8=AA=E6=96=B9=E9=9D=A2=EF=BC=8C=E5=BA=94=E4=BD=BF=E7=94=A8RCU=E8=AF=BB=E9=
=94=81=EF=BC=8C=E8=B0=83=E7=94=A8 ``__task_cred()``
 =E5=87=BD=E6=95=B0=EF=BC=8C=E5=B0=86=E7=BB=93=E6=9E=9C=E5=AD=98=E5=82=A8=
=E5=9C=A8=E4=B8=B4=E6=97=B6=E6=8C=87=E9=92=88=E4=B8=AD=EF=BC=8C=E7=84=B6=E5=
=90=8E=E4=BB=8E=E4=B8=B4=E6=97=B6=E6=8C=87=E9=92=88=E4=B8=AD=E8=B0=83=E7=94=
=A8=E5=87=AD=E6=8D=AE=E7=9A=84=E5=90=84=E4=B8=AA=E6=96=B9=E9=9D=A2=EF=BC=8C=
=E6=9C=80=E5=90=8E=E9=87=8A=E6=94=BE=E9=94=81=E3=80=82
diff --git a/include/linux/cred.h b/include/linux/cred.h
index ed1609d78cd7..b40ec3c72ee6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -367,7 +367,6 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NUL=
L(_T)) put_cred(_T))
 })
=20
 #define task_uid(task)		(task_cred_xxx((task), uid))
-#define task_euid(task)		(task_cred_xxx((task), euid))
 #define task_ucounts(task)	(task_cred_xxx((task), ucounts))
=20
 #define current_cred_xxx(xxx)			\
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index c0e1a06ede78..b46b1433a67e 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -28,11 +28,6 @@ __rust_helper kuid_t rust_helper_task_uid(struct task_st=
ruct *task)
 	return task_uid(task);
 }
=20
-__rust_helper kuid_t rust_helper_task_euid(struct task_struct *task)
-{
-	return task_euid(task);
-}
-
 #ifndef CONFIG_USER_NS
 __rust_helper uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_=
t uid)
 {
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index e07d0ddd76f6..169ff1dde936 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -218,16 +218,6 @@ pub fn uid(&self) -> Kuid {
         Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
     }
=20
-    /// Returns the objective effective UID of the given task.
-    ///
-    /// You should probably not be using this; the effective UID is normal=
ly
-    /// only relevant in subjective credentials.
-    #[inline]
-    pub fn euid(&self) -> Kuid {
-        // SAFETY: It's always safe to call `task_euid` on a valid task.
-        Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
-    }
-
     /// Determines whether the given task has pending signals.
     #[inline]
     pub fn signal_pending(&self) -> bool {

---
base-commit: 7dff99b354601dd01829e1511711846e04340a69
change-id: 20260219-remove-task-euid-19e4b00beebe
prerequisite-change-id: 20260212-rust-uid-f1b3a45c8084:v1
prerequisite-patch-id: 7ec4933af3a7f4c6bb0403c34a6dd41306836295
prerequisite-change-id: 20260213-binder-uid-a24ede5026a8:v1
prerequisite-patch-id: 7be0128bd8902879bb271d0587ac98bf242cf612
prerequisite-patch-id: 4a9d0f595d2084b3f8982a2d0d8b3df35b9fae0e

Best regards,
--=20
Alice Ryhl <aliceryhl@google.com>

