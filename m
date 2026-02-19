Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DE337BAB
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503293; cv=none; b=QvW6JK+kIntAxkfMiwfMquE+pvuJstIgefTtmr6sLBrXs0n7Q8VBDcy9zEjGFbU/l2X0n4ZgibsEkquIR/2wkdwAkVqShATtGEPUc6hWgLfxBHFMHOxs3usPwwG425SbIwgTwHlvh8IVD/4lF4ouxIGFNB4ec1A0qK7zK5pjX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503293; c=relaxed/simple;
	bh=N7QWx8lvrILyEvgp6mZjh3HPkzg9pLQ3PAPFD0z2DLQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Oh2kih9kOKSnm6c5FivkSTveOIXF0rHSnTo4p4Ze9FjFZpJRRZdFlkM8m6OFd4gEGkNL4MthsQ7NtdvHhxTAh/1hGIK4IqJqy8qnuw8F/kjZQp9aJLmK3iRiXSaJ7h3p8smjsXBK4xLLp2YMs9pYw5YUIfun/+G7ZmbtbShuML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAJBt5d2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAJBt5d2"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so577868f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771503290; x=1772108090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNwX8+RHMQ84U1GAHoDn1BhLLCMkOCjMDxLLvceuQlk=;
        b=QAJBt5d2ezObTBI2rkFxQn+AFj707HihxLFV2A4nafIpKcXkAH7338EcHMrs4T32we
         eXORDxetdfwVc1WAnWTCtsm5D65z4IM+jb2w149XXvH/WyXO2f5Gsyf9sqy/K3IbKSzZ
         NaLeXyt+UvYXLPVAAi2FMc3sbDypbL1ra5dYKJ580mDI6z9SeLZuydrStRPXsCskyLg5
         OiNaJsSDNudG7YID6WU+r+ikVx2m28xLttITuENoxqooaeUlc5adY0IAwBf/KCm/JGTo
         1Y5/goIXyyK+wdhP4+r8Nvjyut8TbWyQEQCHfqB8uxozvgfs83WglI9S7OfUyDPazrYb
         9sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771503290; x=1772108090;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNwX8+RHMQ84U1GAHoDn1BhLLCMkOCjMDxLLvceuQlk=;
        b=qb5E87NdTuRNvA75jOvRtB/jt/8qGXLv4YtGovbH9oPGoTO8caUCpxq8RjqzQgE2N4
         Mdimpd3DdbqwE5sxFTBDDUCWrxpPsae7S8njuNQ0Um3UTX+EJ78W+gDVcmmCX51kwWCP
         1tLILXEIiqosTuFemhXah+CI9zUjkrCAJT0b7smQF1XxiZHZVONNsN/jqESGCiuI5b6m
         vcHDgg6TsLhPCzweRJLREgNV4t67PACxWgFVOhfk9Z6n2iNnpmhQYhOd5vcGsYBKPHdP
         LdzLxqz79SdYLFPb6lyhf+PFRZM9DtzRYTqw1ZUSSCB0+Ws9DZRD33cWi01njmdibtfA
         CwIw==
X-Forwarded-Encrypted: i=1; AJvYcCV/h6ysMRVL/OigacIDxYSWf+UgTToDu2/L7CaEXkeP0DizySP5lPYx2mt4AuiKjzJlUfGoGOLiW++u7pg/27EDhtOuJvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GuE+5MclqYV33x9PZew9Juq3iO38RYtxsGs+5+z0RzOMhMn4
	yojwP7nXqBLs1lGOS3AO7G7KEOyykpqsX3FlCMuBlYHG8daL7kYl70C/ZcbHuo9bDy5yZpBRpxj
	WhQ4t+6LXaR78o7uHjg==
X-Received: from wrsi7.prod.google.com ([2002:adf:fdc7:0:b0:437:6cf0:16b6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24ca:b0:435:e3fe:7409 with SMTP id ffacd0b85a97d-4379dba6985mr31372338f8f.44.1771503289833;
 Thu, 19 Feb 2026 04:14:49 -0800 (PST)
Date: Thu, 19 Feb 2026 12:14:39 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK7+lmkC/22NwQ7CIBBEf6Xh7EZANLW/YjxAGZUYWl2gMTH+u
 7R68OBxdufNe4oEDkiia56CMYUUxqEGtWpEf7HDGRR8zUJLvZNa7YkRxwmUbboSSvCk9jBOSgc
 4iIrdGKfwWCYPx09m3Etdzp+jcDaB+jHGkLum3FJm2LiONmWw+BV3zVeriUvKNOtOym2s2fatb E03qf/9DbkwePBCWG3gsa0f287E8fV6A/Dplav3AAAA
X-Change-Id: 20260219-remove-task-euid-19e4b00beebe
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pgENU55oRl9YsBWeca4kTA4C+Z4cu5tY3IBLBOhVcjM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBplv604Zmxkr2xkRsjnY6AEffWGY74I0bXCkFNY
 yr6DmU724GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZb+tAAKCRAEWL7uWMY5
 Rhw1D/9sglLFe0zTHxMABBHx1bzG7WsYxxsGynhhZSF2mUqROkv2Ij/7+DcnlOYGRvyNeZiuHNM
 7CqR6zqcO0uDAFBlDceW0ETzWOIb8YTqlRaLZ7sUYBROp3nVdVBqoOmBEC9MXLSio1J3ZMF0Jrp
 C5YX/bgi0qp9R49AFJ+BobX8ndwr0s0PYAAysrzdklRn+Z/+iSFW2BE50Mmr/90qtZqHIDFoC9D
 j/RSWaCrcchhPTusBXNN58Ph6yEDL66VMYZNMzS4zly10psqpq9sQOHonlubI6w+AQiD8Wfg5xZ
 3XA8ZW9N3BYYSBjBsQ4v9GleLTmP+DpySoqvsosGbM56OTGSh8y1jI3sRxJfrJED3xbRAItiEeV
 P2tKKN1gyv71d826qZloJ/1kIIvoOiKCmfejdQJ8XNFRX9NeO/efpGmU+lOEKq5lKUxUb10vJ/h
 N+VHJl6JIgsgILgyzKdPIMCVMqLpPYMFTV8L0XsxXQkmBArv/f5d1m5Erl0FMAkFgzl5cEDns2o
 c0v4ejxcu/h8IVGsTrqDLALF7xg+5gbDF7FQKy93f09Ia4QH55Dtu21SBQzKlsMTbsxVeZODnqO
 FxuSg3COcGnL9L/XGYfyHfcZGOAWMr2qW5J7kmm9mqRPQJbfC/VlYc69F8AcY3F5EmopkIjJBEB x1/WV9YXqNzRuaQ==
X-Mailer: b4 0.14.2
Message-ID: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Subject: [PATCH] task: delete task_euid()
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Depends on these two changes:
https://lore.kernel.org/all/20260212-rust-uid-v1-1-deff4214c766@google.com/
https://lore.kernel.org/all/20260213-binder-uid-v1-0-7b795ae05523@google.co=
m/
---
 Documentation/security/credentials.rst                    |  6 ++----
 Documentation/translations/zh_CN/security/credentials.rst |  6 ++----
 include/linux/cred.h                                      |  1 -
 rust/helpers/task.c                                       |  5 -----
 rust/kernel/task.rs                                       | 10 ----------
 5 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/securit=
y/credentials.rst
index d0191c8b8060edb7b272402c019cff941ec22743..81d3b5737d85bde9b77bff94dfb=
93ed8037b2302 100644
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
index 88fcd9152ffe91d79fc10bfc7b2a37d301b4938a..f0b2efec342438b81be415dc513=
622c961bb7e59 100644
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
-=E5=A6=82=E6=9E=9C=E8=B0=83=E7=94=A8=E6=96=B9=E5=9C=A8=E6=AD=A4=E6=97=B6=
=E5=B7=B2=E7=BB=8F=E6=8C=81=E6=9C=89RCU=E8=AF=BB=E9=94=81=EF=BC=8C=E5=88=99=
=E5=BA=94=E4=BD=BF=E7=94=A8::
+=E5=A6=82=E6=9E=9C=E8=B0=83=E7=94=A8=E6=96=B9=E5=9C=A8=E6=AD=A4=E6=97=B6=
=E5=B7=B2=E7=BB=8F=E6=8C=81=E6=9C=89RCU=E8=AF=BB=E9=94=81=EF=BC=8C=E5=88=99=
=E5=BA=94=E6=94=B9=E4=B8=BA=E4=BD=BF=E7=94=A8::
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
index ed1609d78cd7b16ed1434c937176495a4f38cf6e..b40ec3c72ee6673c7be5210a166=
7e3912cba9620 100644
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
index c0e1a06ede78c0b0641707b52a82725543e2c02c..b46b1433a67e8eb341a7ee32ca4=
247b304bf675f 100644
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
index e07d0ddd76f6917adc91ca3d17bb7719153ee17f..169ff1dde9363afc8914b431fe3=
1f2238b213ada 100644
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
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260219-remove-task-euid-19e4b00beebe
prerequisite-change-id: 20260212-rust-uid-f1b3a45c8084:v1
prerequisite-patch-id: 7ec4933af3a7f4c6bb0403c34a6dd41306836295
prerequisite-change-id: 20260213-binder-uid-a24ede5026a8:v1
prerequisite-patch-id: 7be0128bd8902879bb271d0587ac98bf242cf612
prerequisite-patch-id: 4a9d0f595d2084b3f8982a2d0d8b3df35b9fae0e

Best regards,
--=20
Alice Ryhl <aliceryhl@google.com>

