Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529535E1D7
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948102; cv=pass; b=Q/opcb70khidU73e6c4SnAhWjZSo3nl7bAiKzrgzJlagIqOZmvePyznTgQhFjM0Nb46Y4vRFbkdff8Z2j1Akqedxxg78o1LTNqDmAyY7l2x4qOsWT2ql1DYXLKltpa2dx3tXdRKS4U9GJWkwPRe5cAQApGbUH1fToUhok8kJ9xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948102; c=relaxed/simple;
	bh=FtJm1XMA2u6fuGzBGX3Jb1FioFwf8hZ2gXCOXmPtfVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQrcSDb+oCZ/vt/vb9S7KG6UYGBkOTUDoNI+vyR+cq2R8gIF4zFJs/Lol4fql3z526ctWDlp2w3mNravL2/yGFlSm0KGlLAOG6lu1xf7IlQ6CK81KKqqGrIr5Nt3LN7zEayQc/hthwkey9v3gVgtXWPQcjN4M89058ss5C1epek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkcKu5l5; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkcKu5l5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso691219a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 16:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782948100; cv=none;
        d=google.com; s=arc-20260327;
        b=KSn2KANpEDwgLNUoskg66I/HEZmsrTmAJ7vD5T8s6rLNdKrKAqeaRDZiJLy0R9qj82
         mMBbryjEfO8NN5Vfk1RUBjteaYUSqcGyZm+Fux9NlEPIm6PXXXrj9t1eGi7Bbv2CHxp9
         bUzGsZMlmkfjoPJtnbA0yswDN04iaBCMBLW2AvXZKvXitrYlR8sEQcdICcGmwBtssJ3n
         Q3k85mLGe+jEQavb8307NOjrufO3EKW77N6tvsiP1DBiNP1KLqA+N6EE2/ypYi9QeEEm
         TvdESsH7atS42lLxwd261KcPTsFdeUyRws0ml3ZfYSohhX9POT/15ZsTbHo1I62t794s
         Nblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        fh=YF7L9Zt2oyuZAoXHyp+A5dvMjKUm+NyTfK+tm5Cpwtg=;
        b=g8wx+tQCEZo+PU70yNlsS1obdQvFJN+/ws8IL3xehcyK0nKZ37oURziH/o8k8SCn9D
         /a7Sj7Dwxei0rW16aR8LmJ/wfwy9maqljA1TRB7yqlELDTqEbR/z8m5BQ8dADp9Nx+HU
         QsYOt6ucJWBxTKgJXSawU7iZY/xYTFiltNE+U6iA2+SlRMaGd34IzqpOCOaXBTtadC+4
         D5eV5r7iNOgIxXFJkpfif6lIiViTd66wKSl03b3AXCkIJMYDGSCbL5D714kgyRP6iLCD
         QD6fx0gtFl3+3tFrpjayt0UgmJKnosaTvIqcokdaXHwaUh/qQPNBkj6sDJJcTCX7RNld
         PnVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782948100; x=1783552900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        b=ZkcKu5l54N20I+XXhjeX+Snq/ceTIYqHZrOU+F8zxdyybdWsf363sWsYa2/iCEwBUw
         5TkCQ8X2JlbeMTaKIxp6yJN6T2aqUx3bUXxsl9MlUqrkOFPKUYGtYbSgUwuP6FySolud
         b+YQnpEFriP83EOArtC4uRZsaj7FY0+ox/1NiBPmwzue3EfDkcbR3yl4WmH09XyG0ome
         C1bFhOFphJ5zkohvjbWWT61SV0BhTmGkNdV5ztmdUAGIc6ZylDS5L1D80USdAKMFzSgQ
         iCnwIX2O2SnifZTohViHr356Za0/WQPWreUCRcpOmXNL9Wn3mOlTAB0UUre7Jbw25EpM
         djXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948100; x=1783552900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZhVbL00Yg5I6i6D230lOzIY4kpLQfWeLuTF6oDa7To=;
        b=P3urtQkZM3ItJb71FPn43egS4Cq8w4VAir+tUR2ed+SOU0FMEmZCKVQOut8Bjpg8oa
         TV0GGiEZVbWIFyV52WuApujigj4HX1pq5U/BhSGzvKGXW00pGjdkNlWuOkP8mcuriWFg
         LMOgeH1lzo1Mofue0w42zxoPmsHHI6SgwWDNZ7B0PGJ6YscEtz02uAAPQwk4SuoEEkfd
         e45iTt/yz6u4TN8xodnr3aGF8ByChpSxs5UWzLBmKDN4QTK0yrLrIFgB9cztFA9MtSOV
         IkWQrq2UhmAU4+sbYMBabC8Z6hVabaONI8eQ1Sdrs7BvtaRl7gs908IqXkRlhzionDql
         v7Uw==
X-Forwarded-Encrypted: i=1; AFNElJ8+W0unCSENBHV6WE5eTMfj2C3TmZ9s4VVIyox5QxXbAbn6yUUQSln/XCzpkG4ZffLnqGPm6EBDZCIoizKit2edN5eyhVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0oJBZNTrn3QBanXhCTim5O8I0wyyZRvlBBnaE0Wk1GaggKWig
	E906IPPKWCVxeDLPBAU4CQnxnewUadrssobUn/vS+UMhDseXDSyV/VxPMMPjAWGdaufIxHb6DI5
	URPq8/N7N08p0QcAqgV0FAg30fo9tYMdQh0l1WMD9
X-Gm-Gg: AfdE7clTvekTj8c7c8NAocjvuXAla5qyC3u5XMGjcT9LJZIwFHUBnVEOCF6NEX3t3Dl
	Zs3NugFbsms+oKYqjWzJ3q3m2AMJgQbfVLoGJb/WLFYBsQ/5DIV0vX1Qr4ioH/cSfV8XqA/cuRo
	8XaAiqDcfxQg0S3b2QiO9aipfytnyXvBst7f+1aRaZogyk8Q5ffix0uILhHLMILqjhsHEhXRzJy
	PJd9mHMYG9mCYUCL2IQzYa9yrwJfMwDo60TxMXK3mizD7ffea648Zv/6H9g8L6f86xqc8TH
X-Received: by 2002:a05:6300:6713:b0:3b2:8675:4866 with SMTP id
 adf61e73a8af0-3bfed471c52mr4022346637.31.1782948099973; Wed, 01 Jul 2026
 16:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
 <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
In-Reply-To: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 19:21:27 -0400
X-Gm-Features: AVVi8Cckm_QE9ya8Cck0-aYUUFKQ3gs1NVwV2FqpNlxb6AaTiQhAvZrnWz_L4W4
Message-ID: <CAHC9VhTTjkHG7CQ1ptku3TONh=6bzcwVwqawAYggX3Z32kUy5Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:58=E2=80=AFPM David Windsor <dwindsor@gmail.com> w=
rote:
> On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> [...]
> >
> >   kfunc bpf_init_inode_xattr(...)
> >   {
> >     /* sanity check params */
> >     if (!xattrs ...)
> >       return -EINVAL;
> >
> >    /* get value/len from bpf dynptr */
> >
> >    /* hook will check for LSM specific xattr count/limits, allocate,
> > copy value*/
> >    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
> >    if (rc)
> >      return rc;
> >   }
> >
> > David, if you like I can provide you a patch that implements the
> > security_lsmxattr_add() hook above if you aren't comfortable writing
> > that, but if you want to give it a shot that's all the better :)
>
> Makes sense, I can do it while I'm fixing the remaining issue flagged
> by sashiko.
>
> I'll route the LSM preparation patch containing struct lsm_xattrs and
> security_lsmxattr_add() through security and the kfunc and selftest
> through bpf. Does that work for you?

Yep.

--=20
paul-moore.com
