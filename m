Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBD36D9EA
	for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698383; cv=pass; b=gFTBtAwfDpKoQunt0mgB6MsJQpgUI2bASsNOB1M2T91TSvNu09mN9r/9nwSDzsOsL2PRB9O43nYsQ/Eitmdlz94uzMpDC2p/koGZyHnlJ/q8uNkZw4YLvrvtIDA6WGm5tyeu5zkvhexH99XLw+y3OLUGsoDmYtv5ZsNIbd1cre0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698383; c=relaxed/simple;
	bh=9QvEw0u3gRMsyoZyk+ByF8/LpMUDYgdZiDWMnaQ2/XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsRJ/70fcTmYN3OECGEQ0s5ED463NoEAPzlTZUQnARuAYZby3d08j47D5yJuD1Jm1t0wDHF27XhOwBklc0dMrDWLPW2MZUxdOOy09sXzS0fo9N/5MTKlmUiHZwA1/8p5csrvsFLaf7CY7KtiiHS3n2XidrWQ/JWjM8cfmU+vMP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HU2mPT0z; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HU2mPT0z"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a02f3b8feso2063472a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Mar 2026 14:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773698380; cv=none;
        d=google.com; s=arc-20240605;
        b=c8xZDImNBo2dltzKs9LpA50sm8mPcoxso5Taa2lcz8ytY/67+u/kmzawFDHMk/F9ni
         Mahbzbkha74Bc94hcuxiJQ7Zp3yB308M08FDSpCSGUqwLtobFwzNn2PTlbWJUikEolIG
         0J1rfx9wSkf8iXYomVtbhSZkW/ltUI4erveaW5kvwXfkYyCbmfANF02kD10rUl2TdEwL
         cgNJX+RPKUSiq7B9MxXtuc53uPagfR9z6GeSicG1tApRLpoF+0Uf/ugmXyGM095wg4G2
         NrRZ4816Ou3ohqciIVJfxKnIh3QfANHES5o8cgC0/79sBu59dwLxWhXZluxdZ9atvNAQ
         2mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        fh=/XpAAIYvsh+24QrHGHWY/Lehbv+i1IXtGhm0V3NZrs0=;
        b=HevuvBEE0yIRzAvyulE8tw+tgGZMirvTbTyL5pCknNF8Biiw3X6KXSLTW6Ak9PzuV0
         EsuZTZNzNw5B9I17kYHWjyJa+52SW/vzppuZ+gXw1+dJp4JU+m8b19XtuQo6f92VnZFn
         zRd8/opi5hnOCLTrqhlUhGiRB5p1zX48Gcn/5vkUcj4p7X8IUIrIvkYVYjbeb5/X+ZVX
         mIgACs1F0EcI5m9eQ0urPRkLY7KXlIJ0Bshh6X1uyE0KrJ236gvzz3czQLfrTHqud/ii
         djPyN1h8OuVCaSvOATzcQBq6dYksBHM9syjZk/l5yIY3RH0NIq8tvF32SNCcsLo1MZ3f
         lGgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773698380; x=1774303180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=HU2mPT0zGfye+/qt/BFyxrPvSX5E+ihjGJ8Y4InhP0ZJvO9/oqaVYHe81A8EqMLY9n
         xU2NJ5CFZsOcC4CCvwcMIJe64nzNIJ3kfF0ugjwfI7/ilGdmaz1O81K2ca83xOXNx4pG
         u5shmfWd07pd/6yNfyIehLkq30Hge3Wg9NaaQq9/nvH6FqwwR2qeJWI0JQn/EaJCjLXs
         DGiDBStBpweklzGz0rVRg05tkC3XSxE/ardUCgHyB+UYg/TK7zsISfRzOaa51T/Pcotc
         FUvPsuHniOQUOd21OTKKY4quYDE2SsUUG/cmse1HPkElVXGLqb6iVgnOyGsjlncONey7
         qQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698380; x=1774303180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=UlvXG6rE8G8J7XMUQNYMMIHSeWgw1d1V8bL6/nEvfGISSW+5CKdjoqxGjmO07GRNhq
         9OhsB8wgPR/k65AC7pmW66uO+hrJLNRlMBgNbNWmQquRAdE/jFsUv+BlJkpw6kdel3Gt
         p6IMDInnKT1N3JzG3qvZaTWif9yJFarv6AG7jcGVyl6gGdw1RX/blOMIoDHW7ahvlU09
         1dmw7/mRU2ZxOWjGYp869HJt0UzuP1WHrSfMlhe64eO8niMa7VjOjiepNiDen1kKWFHa
         GcZ4Ih3fRjnp5MjBM7NkyHgafG/xJpeRJTc6+egdDHMZenpx/5ffet8R78bh7wScBQto
         0F+Q==
X-Gm-Message-State: AOJu0YxmVYa/GaG870gBjSkkisprZQ6CA/VGxUM7X7OfEI7OVaWPTzAw
	6x3Yx6kpjX2MnH3HVr7t4NzsxYUiJ67BK34R87sgoX5X36V3GsYoLeKIBJh0OUSKGZ8Os40LBPt
	H0RYwMRYOkvCm+oPqKGUFz8eu248qNfqT716sXxJBdfhQS4+lNXw=
X-Gm-Gg: ATEYQzybYptfxpPTc2kzkfW+UYcJ+lpRcCM5PMSW53K54GsPLYveelAUDk82NvECWnt
	PBZyXArml8A8fn/qLmlRFVso5xBsSSY+miacu8LNkLCqYn559Fcb7AdYTnRQyoN0YedVHJnf4mt
	4Zmw/aze7BPbaba/7wBOmZeLEo6040FZXdls8sdCNccazYF1YUvvTV38wHG22fUq40x+Tp87jGr
	mxfZfElHUBXSyXUFYju/4JfMleEzmT9kim8mIG08nqeU0x70E5lqusfMrHf6gN/0LKhGzeQbh1c
	xHkrjp4=
X-Received: by 2002:a17:90a:d60c:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-35a22081eb3mr12428760a91.33.1773698380402; Mon, 16 Mar 2026
 14:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 17:59:28 -0400
X-Gm-Features: AaiRm50Q0DM9xRE6xrYOCEeiOu8cKoO8ieFIUmC4mYeVLGbPolGQ90N17nL41QA
Message-ID: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing mmap() and mprotect() LSM access control points for the
> overlayfs filesystem are incomplete in that they do not cover both the
> user and backing files.  This patchset corrects this through the addition
> of a new backing file specific LSM hook, security_mmap_backing_file(),
> a new user path file associated with a backing file that can be used by
> LSMs in the security_file_mprotect() code path, and the associated
> SELinux code changes.
>
> The security_mmap_backing_file() hook is intended to allow LSMs to apply
> access controls on mmap() operations accessing a backing file, similar to
> the security_mmap_file() for user files.  Due to the details around the
> accesses and the desire to distinguish between the two types of accesses,
> a new LSM hook was needed.  More information on this new hook can be
> found in the associated patch.
>
> The new user path file replaces the existing user path stored in the
> backing file.  This change was necessary to support LSM based access
> controls in the mprotect() code path where only one file is accessible
> via the vma->vm_file field.  Unfortunately, storing a reference to the
> user file inside the backing file does not work due to the cyclic
> ref counting so a stand-in was necessary, the new user O_PATH file.
> This new O_PATH file is intended to be representative of the original
> user file and can be used by LSMs to make access control decisions based
> on both the backing and user files.
>
> The SELinux changes in this patchset involve making use of the new
> security_mmap_backing_file() hook and updating the existing mprotect()
> access controls to take into account both the backing and user files.
> These changes preserve the existing SELinux approach of allowing access
> on overlayfs files if the current task has the necessary rights to the
> user file and the mounting process has the necessary rights to the
> underlying backing file.
>
> --
> Amir Goldstein (1):
>       backing_file: store user_path_file
>
> Paul Moore (2):
>       lsm: add the security_mmap_backing_file() hook
>       selinux: fix overlayfs mmap() and mprotect() access checks
>
>  fs/backing-file.c             |   28 +++++---
>  fs/erofs/ishare.c             |   12 ++-
>  fs/file_table.c               |   53 +++++++++++++---
>  fs/fuse/passthrough.c         |    3
>  fs/internal.h                 |    5 -
>  fs/overlayfs/dir.c            |    3
>  fs/overlayfs/file.c           |    1
>  include/linux/backing-file.h  |   29 ++++++++-
>  include/linux/file_ref.h      |   10 ---
>  include/linux/lsm_audit.h     |    2
>  include/linux/lsm_hook_defs.h |    2
>  include/linux/security.h      |   10 +++
>  security/security.c           |   25 +++++++
>  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
>  14 files changed, 231 insertions(+), 60 deletions(-)

Due to the nature of the issue, I'm going to merge this into
lsm/stable-7.0 in a few moments so the changes can get some testing in
linux-next with the idea of sending this up to Linus' later in the
week.  If anyone has any concerns over this patchset, please let me
know as soon as possible.

--=20
paul-moore.com
