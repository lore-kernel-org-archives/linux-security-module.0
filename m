Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DE3815DE
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147944; cv=pass; b=DSpup8U5PC97FLvdJ73ybfYHocI34tBPk9AZsK+D2z2AIrJm2lhmGjaieii6dBF7mOdKQD8ErO6XleGFTmyWolSaHDnyIIeskTgA00WVnpJb6RvEnng4T8uA6AD7D2BUDJ4I4oUr7ehSdqaXCcpqN7gebDBgY2rAGQGRkGm8WBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147944; c=relaxed/simple;
	bh=kW8qgpTiEaxSYdpL6zxHLeLhCoMuclZGCtfSmKy5L2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvsFoU5BSDUy5A0dYlt1hXLiQuQAt2Vn8osmLV/eUFjKuNTbLyYMBZpYMTs5+WHxy8p4I0vrnqYm+YyUVLMRkUSKqo+GyQ1EPo4DhLerL+3SCevFU2ytmgvjNGkEuyk46ihabDtqzekzZUIILiqEMqv91NxEDankROvNpjKlU/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UqheGuyi; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UqheGuyi"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25187so145311b3a.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 10:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789147933; cv=none;
        d=google.com; s=arc-20260327;
        b=OgLsT0YXrubL7g8g4o4EREPDaJ1BrWA+ZiBHHzIRwqWYONICAyde+SnhCo0zXcGhrk
         KzWxCqSf0uK/+Ax/p5EagQEVs1JF/zGMa7qqbouETHUwaJQMsZbZXIk0HRZkgS7uydbk
         y80S1Zv+mj+ePfbcUG8R7vc5FAFB2YpQKELJbINglQK7bLlxN+yy1W0VMqGGCeLmhdTY
         HUrZ2PevQB0xdmFI3T3Isv8NtFu6Ps5lmABdtp/vbcf9mz6B5ZudSQTZUp0atxS+E84p
         qEBRKS6kAqQ1UeFfQUs/GN9IxE6AQ2cDKUr9LZRhCsUDjppw5/duDllzx9qJ8CvUnh9U
         uleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        fh=TMiGYuXLWTB0HEOE283kd74kl1A+1tx5K5q13zni3Yw=;
        b=Lo8hL2zLj6XYIwfkYp6pnFw/PjmOdDmavOGe4JHkUkmXxbj0Oxl7SiwFD7C6yOYhOI
         roL1VOKB8O4IbU/tRqVc4fHykRjZWkLFA/TX39cdkfJkdMC1LplpfwVBq6myV9Z5fHFv
         Ly5frWoh1K6Vz4xA4bGqULu1IlGS0xx7q/eS75tpoEsfsUWlco9AkQ/+zn+y7P8oGcgH
         +xpDa7gqMC6Nf4G8dg4ra8AMyb80gtmDrqi+cVgnzryGge+eurwaIG9SZjYarj51tlfq
         kbcQilE70Ett7jOmPANrMbQTdIxHlAhP7Gi5a1ZesBgwaaTNXXvOWQnRRhHNGDDD9qiN
         1FfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789147933; x=1789752733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        b=UqheGuyiMjVVVOGiGccV3JNOZLv/PFYpRUiMDAjQNm8RkpDr0WmuuipgENB9wmjWLI
         d065p0jjbbC6cZl63apUcS3hvWckD9G+9V4dzqEsLmt4gk2jMcEZW31CYrnb3SyIGMOf
         6w+uVr7S8KCUf/LHJbQTFwRxpW33OFdwzs1B5qT3Tr/QyRoxd0WNYGyAHW1PuQBU3SVt
         2rWVculH+MJGux8tqBgkPbUAlKjsRydWlK0w1fepaLF6AYpTCJFAtcU6krEn1U0radqR
         5QOajehVZL7gRzjzpaI3/zDfZomxje84fZVe6Ef8wcenlDyZ6OGMnmPNZ7XyeoMeQpmA
         wuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147933; x=1789752733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsPcTSE7tXZ7STQaDrKcB3TWLUFfJE17N5WpFurAIfQ=;
        b=civsDDIptEeUMO35DjVY0fuQMcYPgtQ8b/YFWEyQwiOChAKZ8Cug0Wtpg4WYaH9ead
         rtjNHO8JmQ3bZdnzMEYRFbR3ue44TmDHncCe+Bio5RGdPfW//x5ZeWhQkXDk8zHKJK5I
         ax9E81fBId01F56ZJqZWbQlOmM+4/BW0gBTljUEkjy05TAtf+QBnQQ40wFR8iHyGQY23
         MGLdKswVLPFWJFlT1SQujxK34SRbtnMQ77JhvBIf3+2o5pL1nEh3gfucO01LVGjP4SdD
         mQktDwH63v3QsMBVSd+uElMA5lWAxc71WZClOnYwk5wJAx8s5nSBrZ6C/3wGwQv67I9H
         IMnA==
X-Forwarded-Encrypted: i=1; AKwUvBzELU74FOOuDi9OJcPV9qnO8A7gTTOWx+dMWHcuu1Gr+hoYFCwb0vFJXnS9tl6fYlZA+QKbceJgNVfj72IRhpPUV3nmoEc=@vger.kernel.org
X-Gm-Message-State: AFuF++kah6yy1pKGtqbKr3Bo/c7BrUe4xDztM2kxo6RU3qmo86xGkJ4i
	nI9VJBopdXbme9Ec/CXI9LC1ppkLFRGY4dTcP59TIYMn/C8T9rMi4OZ1NKt5wVA+zLgZqjVELjt
	IwRyfLGNB7NpCB0bD0TeXEPaHaHWrXUzafWJGsMai
X-Gm-Gg: AYBFou3RgCNychsYLR4X3qWb83p2FbXqm+QqimXKRHB6IbxgCKxLHilqBS6yR+zxeJq
	DrNV+V8pNBV8lPKZ0wO7gu4bOBK7R/2q2eFmsfCnekQ4HwgDR9J5beHjdeE4ujaXhF1FYZdOcOu
	umHMa0Jdcc3QjIOUHrfS17Gxtyd5Hh+xVq5Wj0sCHe4OzVE+w1+yL28iRdMu/zrbmZx7wrIDGac
	H9TfL4g9pHS5uFdF8RnwtRQsVMpgGLiQzUR/BJRgdhDiHANbqmj6+L6GFsbMYU+qLv5bbaAYFmI
	o7mW5v3PbIbPk2YkGZbY7MUSQWGCD3ewkfYl60WprXG+LQ12ayvvSFKxCOlcscyfwbBf1b05R2I
	IapTtXLIESsrOtFyii1CXWw==
X-Received: by 2002:a05:6a00:419a:b0:845:bda6:574b with SMTP id
 d2e1a72fcca58-86b2e8f6e10mr9085747b3a.5.1789147933173; Fri, 11 Sep 2026
 10:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com> <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
In-Reply-To: <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 13:32:01 -0400
X-Gm-Features: AcwNN1VMGI9zz0tqqwR_fG_D5fsVL778Ou1jXQO7hFzumGc64ffvrJMBWIPUuH4
Message-ID: <CAHC9VhShjf770Djx8_unbeWpO_ni0ahMFvrGFpaUcyuHzYgCyA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: daan@amutable.com, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:27=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/8/2026 3:05 PM, Paul Moore wrote:
> > On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
> > <devnull+daan.amutable.com@kernel.org> wrote:
> >> From: Daan De Meyer <daan@amutable.com>
> >>
> >> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> >> and permission hooks. Update the in-tree security implementations and
> >> non-VFS callers accordingly.
> >>
> >> Signed-off-by: Daan De Meyer <daan@amutable.com>
> >> ---
> >>  fs/cachefiles/security.c      |  4 +--
> >>  fs/namei.c                    | 18 +++++++-------
> >>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
> >>  include/linux/security.h      | 58 +++++++++++++++++++++++++---------=
---------
> >>  security/security.c           | 40 +++++++++++++++++------------
> >>  security/selinux/hooks.c      | 19 +++++++++-----
> >>  security/smack/smack_lsm.c    |  9 ++++---
> >>  7 files changed, 100 insertions(+), 71 deletions(-)
> > Casey, are you okay with the Smack changes (below)?
>
> Yes, assuming the 80 character limit is adhered to.

I just checked and the smack_lsm.c changes all fit nicely in my
80-char wide terminal.

--=20
paul-moore.com
