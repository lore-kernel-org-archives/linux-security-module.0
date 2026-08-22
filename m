Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A1302163
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401756; cv=none; b=vEFk4pb7dK8nhXhK91QLPojrqWHJUQnD5C61ZLZ6mlUIKGHR+w4b1+fd4QeuKUKHQQxpFWAaNIxR579zWE7v+c0m6UoJ47qfAPBJNx3eJA0XsOo04IjXKWbbTMCr68FodEE3ZrkoZr/7kubiJ5IJJCSb7GDJcTI9aSqLl4c3Ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401756; c=relaxed/simple;
	bh=4yHzd0/sD7uWBpqiQoo6tgH5+VFqqncgDUgCAHisFbU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=FC1snPbN5cdJ59m2iXVEIAwR6wg3fTXn/85pSCP2uwp6cwxDt6b/aEE2Q2Mby/nEJTkaOSR9Dzmvtv1DApByjjDX2kfjPmQH+QSxAHPrvovfdmnaQ0cWcFPdPPB8TIowe3yRx83GJVdAk2gEPHlm11vOrLAX2Sc4Vsihq7lYh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=LpNH3huC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="LpNH3huC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15f020a223so284752766b.1
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787401752; x=1788006552; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7iKMrQWKrNcFUdtPEGrYqrgrtfQs5EtCDckx7iIZKg=;
        b=LpNH3huCo2K9HkJ0ovRFb7spQxXj+x+JTiRmAhLHbpHuvAWqrEhO/bI8RasRauLmPk
         Wvn0FdvvaGdm9KHtrVyom2xyO5pcD0UXpBquN8JaU0y9AaOqIKMPxjO7oQiO/qHmucF9
         Gs5x13Xq1gHIhZVr9G+i73flJzH4j9AdVgnrVle5kmO6mcHy2ZYYK1WhpL+E+JIFH+Z4
         WKh1RWYNKt4lhReJEgdh9r5oVf+2Lcb2ZEKhjaO51uzAAQKyKrYIZh2GFDHXgnQvBCwi
         dT864mc6DZFio4tqMSSh801Pgvc4yYWtXVQReZ7n4tGVVThXivOA4X2TrJDIYSSvNVaT
         aDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787401752; x=1788006552;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7iKMrQWKrNcFUdtPEGrYqrgrtfQs5EtCDckx7iIZKg=;
        b=EGs/aGNbw4UnAqMYfXIK3BScckosKD/GY+HA43Udp9NLz9EzUgm/QZpJzP0xsdfZWG
         sKZ86OxNQvY5v23ca9OO4akpJ90A1j0B+X0BsCJWPSCKarNzF/vdUMKqeSk5jXR9nzW9
         T08eMdbVq8jG5uTMTznWkug8Ch6jLXaOCeaB0Dtk10NsUhtE1H2layXTzGYA8Za1YO2h
         CgtMvwJTkia6Y/OB+PAd5wIzuogHJ8bL13x3L5UwGyCXn0xmsdfm+MkEqVVH2ziwh++O
         2oaxF1v0nu4zkxHIUy4graDQwmB4yBHoercyxkF1chIkMMoF9cWBOSYM45w2tFLiWnMy
         YC4A==
X-Forwarded-Encrypted: i=1; AHgh+Rr+ngIXJtk6B+82Q/uwiYED0peKM1qtO1LQWVQuWnbqeX47h44tDVYD6kd6hh8+GstPYfKS6WX4csyEb8foFcqpdeOH+Ks=@vger.kernel.org
X-Gm-Message-State: AFuF++m0G71ZQqqOA/NoeznJdTMFbgSZ04ZvIhpRyNFJ9ZWVlnR7U891
	oSXnOpkAZ2/L4Mn+zlCXI1Axv+/B8IFu+28LL3SH8/JWAoObrjbRuAnCjd3ENo4BKos=
X-Gm-Gg: AR+sD123H22akbWn+LtCLxngUGe635Dx53gz/ebQJhBsVogzjpPVW91/8gse8RFGeeZ
	a68CbTVqDkmIZilZxyU+hA1IEp0Ygm4323FkY+r10YZoUzIg/02hR60l+wlUDx6y/TRudKCajUm
	SNxN7qvRNNV1wn8OwmWC2mDeZ0vZ/DfuWyRVRiD/2Ds70Xh3uA6kFt88vqqFZfnUY0xVxlHTnsP
	dwwUwNREbcwprqddH0O+CswZw7bC8V7e+VxZ+OtownNyGoUOfBYuyRHh3KFj4S1jcrgaM1+ObdD
	Rt3sjlJ6a/Epe8U0iaLi11B/jpSwaiznOaSqczpxktczlvJc79hZAsAt8ipX7oplMWiv1ggnY44
	A83HFSHOx3nRsaPjm7cF+rQ250udD6sDaMfERz1vB79fRG3lKhmw9TUQaTbu7yzVMwHXdkkx957
	2kBBAux+GICGL8KbDHmgLMIKKObMlHifDuY9gdruaRA1Y1C4mc7O5Bx+pNYWhy54KmUAt04e/Dj
	ShBrS+RXYpjXvAl2HjEiTGa/UiYh/t76jdJGZNNVC62eN+rIdp85vha4rP9U899usd0tK+MqSjf
	owsaMkhDyNJa0+tJ6iHUnw==
X-Received: by 2002:a17:906:eec1:b0:c21:61a6:8825 with SMTP id a640c23a62f3a-c246a72e5e4mr1468035066b.22.1787401752232;
        Sat, 22 Aug 2026 05:29:12 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b60asm314268366b.9.2026.08.22.05.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 05:29:11 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH] landlock: Fix use-after-free of the source's parent directory
Message-Id: <E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com>
Date: Sat, 22 Aug 2026 14:29:00 +0200
Cc: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

current_check_refer_path() reads old_dentry->d_parent without holding a
reference nor a lock on it, and then dereferences it in
collect_domain_accesses() and in the audit record.

A reference on a child does not pin its parent: __d_move() reassigns
dentry->d_parent and drops the reference the child held on its former
parent.  hook_path_rename() is not affected because the rename path =
calls
lock_rename() before the hook, so the source cannot be reparented under
it.  hook_path_link() has no such protection: do_linkat() holds a
reference on the source dentry but neither locks nor references its
parent, so a concurrent rename(2) can reparent the source while
security_path_link() runs, and the former parent can then be removed and
freed while the hook walks it.

Any process able to sandbox itself with LANDLOCK_ACCESS_FS_REFER can
trigger this with a linkat(2) loop racing rename(2) and rmdir(2):

  BUG: KASAN: slab-use-after-free in collect_domain_accesses+0x278/0x290
  Read of size 4 at addr ffff888160bd53f4 by task llrepro2/549
   collect_domain_accesses+0x278/0x290
   current_check_refer_path+0x952/0x1120
   security_path_link+0x1be/0x320
   filename_linkat+0x342/0x6d0
   __x64_sys_linkat+0xfa/0x150
  Freed by task 562:
   kmem_cache_free+0x139/0x4c0
   i_callback+0x4b/0x80
   rcu_core+0x7dc/0x10a0

Take a reference on the parent with dget_parent(), and release it once
the hierarchy walk and the audit record are done.

Cc: stable@vger.kernel.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with =
LANDLOCK_ACCESS_FS_REFER")
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 security/landlock/fs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..200c83372bbe 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1298,11 +1298,12 @@ static int current_check_refer_path(struct =
dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() =
and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) =
because
-	 * we keep a reference to old_dentry.
+	 * OPEN_TREE_CLONE).  Pins the parent in both cases: a reference =
on
+	 * old_dentry does not pin its parent, which may then be freed =
after a
+	 * concurrent rename(2).
 	 */
-	old_parent =3D (old_dentry =3D=3D mnt_dir.dentry) ? old_dentry :
-						      =
old_dentry->d_parent;
+	old_parent =3D (old_dentry =3D=3D mnt_dir.dentry) ? =
dget(old_dentry) :
+						      =
dget_parent(old_dentry);
=20
 	/* new_dir->dentry is equal to new_dentry->d_parent */
 	allow_parent1 =3D collect_domain_accesses(subject->domain, =
mnt_dir.dentry,
@@ -1311,8 +1312,10 @@ static int current_check_refer_path(struct dentry =
*const old_dentry,
 	allow_parent2 =3D collect_domain_accesses(subject->domain, =
mnt_dir.dentry,
 						new_dir->dentry,
 						&layer_masks_parent2);
-	if (allow_parent1 && allow_parent2)
+	if (allow_parent1 && allow_parent2) {
+		dput(old_parent);
 		return 0;
+	}
=20
 	/*
 	 * To be able to compare source and destination domain access =
rights,
@@ -1324,8 +1327,10 @@ static int current_check_refer_path(struct dentry =
*const old_dentry,
 		    subject->domain, &mnt_dir, access_request_parent1,
 		    &layer_masks_parent1, &request1, old_dentry,
 		    access_request_parent2, &layer_masks_parent2, =
&request2,
-		    exchange ? new_dentry : NULL))
+		    exchange ? new_dentry : NULL)) {
+		dput(old_parent);
 		return 0;
+	}
=20
 	if (request1.access) {
 		request1.audit.u.path.dentry =3D old_parent;
@@ -1335,6 +1340,7 @@ static int current_check_refer_path(struct dentry =
*const old_dentry,
 		request2.audit.u.path.dentry =3D new_dir->dentry;
 		landlock_log_denial(subject, &request2);
 	}
+	dput(old_parent);
=20
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including
--=20
2.55.0=
