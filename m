Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506E388E74
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061839; cv=none; b=qFKL0ozzo+eTnC3mQUUtkbBYSj1pMcnUTPa0tIi9izzI5jKcpwgoxDJ1H9DkOHaTye8XsrO6XFCckV5VGzKViYQfblgqrptpaVzSQYVQYyinrNRUEoDHKcxnaEpoV+9Z8csxxZKJ4KU6ihDqinqHlICuQQYcyZA4pbITdQLN+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061839; c=relaxed/simple;
	bh=cv5m+J8quHjxp+RrvQXGI9Lz2h9CwSxAjCeQfqqCtYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NbDCI5I8HOEmZTDd13NhjQVgh9WEW9tMxQ/8E5suEYidM51Oajy2RkBBKCDIJtzW+ho/fDXXeVJKPFV0K8lr2DG74y+TeiWOMz7+CNLkDqqbnnfAR/MdVEhVpK4bKN6G6QIiY8dJF5gRVdQvzeQvSKVKJSCbh5eO4Pw1q9mhK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qt/OSwOH; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qt/OSwOH"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-473941177b0so223643f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 23:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783061834; x=1783666634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cW1xgJct4rIUVF64FDKOuE3W1bWWjQIlMxMa9uWaixw=;
        b=Qt/OSwOHYaSJY00e02WQwwcmZHgOfi0+VqIsHv/cXoVnhbAsIbC+sbA/mwBQVE+jHm
         RNPSUrzZtk+rafOwAIv7C/VsQPs2HAMrk2ocPkNzPK14rg1mMSzgrHvymIsN35P66rPq
         nuLhny/NO9AJ8p7DdCsVOylsX77eXwfDE5r+5XGSdjKyRLCWgYDdWi2KnyRrRZGHqOHU
         gGoTIrusmisfr1E/QBtEw04eLTfgU895XI6H9Fl04HcVqUhRrGDEBJXBo+dUvMhcCtGr
         Pu1qTadmWGg+B78EqA+tvQF5FvMauslR9p7h04d70umWZ66SN5sDFF+Vney9MFUwOn0B
         kG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061834; x=1783666634;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cW1xgJct4rIUVF64FDKOuE3W1bWWjQIlMxMa9uWaixw=;
        b=MW8074v47dIrY2ofZFdtf/iC94DPAvllY5gmb+lHim0VeLolVfLpqu63sOS80pzRIL
         P/7nhsfZqIIaX++sxWoFjNllc8XObDUAx/oQcQbOrRMJOKglOIbaFW04v+JcdwSrQuFH
         btvRyjJvdApndBuA8qpKVgFyTpk400xF/bazluotbJuENSYMmV3lnSTDY7iSP0tBFClE
         ina82CdbV9TkT/tSNmr3d2o8fWtMfoY1em/7uzKuROFsuKuaVxOby4NS/HYx1J12JtfY
         3ke4f6mYE6PLu4LWMgvGMC78W0oiWYVP1Lunb1ClCRVO/bSYovuNLSggW5/Ips2r9Xb7
         7ZZA==
X-Forwarded-Encrypted: i=1; AHgh+RoWusrZIyzqbO6wOTAX3xspVHHbl3uS791j284OtLNFeRKqUucnrT5fZJc0pPMwYywbBYRhOYz5EW9nZ0bd8pcjb+jFQ2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdWF839dULkS5sHChUggXv5LSCXWuwMwh581RKo7qgg5SBHXS
	p6yxe0w5ux7dorOJOiC7pwIGPYsezd9+peKSlzGXRk744/y6ToBKn+VAJVFUqVDQQ0kW1TBv43/
	OQjEQ7AzvSiaZzoehGw==
X-Received: from wrxt5.prod.google.com ([2002:a05:6000:1c5:b0:46d:90df:9c14])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2689:b0:472:55a:ef89 with SMTP id ffacd0b85a97d-47759097f62mr13285700f8f.27.1783061833360;
 Thu, 02 Jul 2026 23:57:13 -0700 (PDT)
Date: Fri, 03 Jul 2026 06:57:02 +0000
In-Reply-To: <20260703-remove-task-euid-v5-0-c90c7e2ddf54@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703-remove-task-euid-v5-0-c90c7e2ddf54@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5389; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=k7dZr0CQTzIcUvurCwCdMJZeoApiVYyv+YRvyaWrWfU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqR11Fem++4KKosCqI8D8y37ZxeOM4s61nbQk+I
 RxT/EXjjX+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakddRQAKCRAEWL7uWMY5
 RnmzEACZ/hgyrN3Ua95FLrJ8iWTcluJCg4Kt9ynUR7von/wbqiE7jVMzse6QA/HFqOnxepgKi7j
 poWLbwm7jnkoigmK5DoFGRlypwdN14RLjomQ7ih38G3QDvO94h7LsCemRZUNbjA+tW7AGnehaPm
 8aEIwD7g8Rd3GDrf8tNaA59SCpKauREWe/QqFM1sdpzaIPyRtzVKzq/+LLkYCQ5NgIVa7ojVt4Y
 ZCCYZ+ZFodAakL1VE1krxN3qRWWMwyAGx9RZ225hueWYODKYN2inKyMzt++uoXGa24ggA1vhGa2
 7435pI2XcTGKC+r6njgulMtZUdidFPO2s5/WS6d8cGfcWZxtVtF9oEbmaa6DXANGImUF47comj+
 BqPrhVccUowl990JVPlgB6eY/wX4aYaz/QewUGueGhqPCHt4cOXZk4ARCmq3xGq2HCFXY+RTZRl
 MotQ6By/2f1vjd62hM47E8Cqr01WTDV4gVDR3EuJiFKJPzqWEW9VFLTNQIRkjh4KnFrXDZ8h4CG
 3/nbTxt0NTDEyFTt743yTY4aJAvMa1EnA0TfnTOuoXv+om2vvoGlzyJPJtbREkXuDvZbgIyH8d5
 0vzegkyHdyYsTg1QgcTLBA2PibJk0TgZ5l5Ih6NRoYxjSckojSvYgVBPiqAXR1XNJc5Rx5o+6Lo CLupUn4Rdj6fF7Q==
X-Mailer: b4 0.14.3
Message-ID: <20260703-remove-task-euid-v5-2-c90c7e2ddf54@google.com>
Subject: [PATCH v5 2/2] cred: delete task_euid()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
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
Gemini and Google Translate, and since adjusted as per Alex Shi's
feedback.

Suggested-by: Jann Horn <jannh@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 Documentation/security/credentials.rst                    |  6 ++----
 Documentation/translations/zh_CN/security/credentials.rst |  4 +---
 include/linux/cred.h                                      |  1 -
 rust/helpers/task.c                                       |  5 -----
 rust/kernel/task.rs                                       | 10 ----------
 5 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/securit=
y/credentials.rst
index 4996838491b1..a39a2a2f67aa 100644
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
index c6676265a985..6ef1750c93e2 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -371,7 +371,6 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NUL=
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
index eabd65bfde12..c2b3457b700c 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -217,16 +217,6 @@ pub fn uid(&self) -> Kuid {
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

--=20
2.55.0.rc0.799.gd6f94ed593-goog

