Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0AC283FC4
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456075; cv=pass; b=GlpwKPEs9S2O0ElxYsP0NlbTYRC/SliNsl6+FUUiMykj/yNruwAyGrldL5PrY/PtaAr4qJYHNXWUsHVklyrxrazq9UtCSdbyHbf6gEiqELdZNqA8mAXJPY9KqFXA8A36qu3tzl00hGt6h9fkxm830BM032oP9DFEM5irM7rNX0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456075; c=relaxed/simple;
	bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZZUlS2mwMbnHTFSM8jb+UTNT5ewiAHe4dTlRqNuUg8nLMFdHnnl8jS7rlO02uHhXzaH1Z57smf5dFapxMzf6h1Ff7NizBlUEia+T9HtwqF8yDyU3vykLSJpeN/Fwge9sJt6s2WgMxXjrr0XqHJeOFQfdi6t2eOBQevHDub/eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/DigPl; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/DigPl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0006ea8eso2649791cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 17:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456072; cv=none;
        d=google.com; s=arc-20260327;
        b=G6ARLCVm5LVyFrFK3DLilTwfCIcR80RK8WMFRlPXEKiB6FuquDd+U4qolFMTDem/7Q
         IkTpJLaYrYe99ivZsQRf3j5KwhGTW/+F73+DEQW4uANUP60JhRpa3BrKuXkbA6EIbajX
         p03Ww0smGzSynVJK/Oxl0wb4v4veMNP/y07xGoo422SLgSYQ2XxX+GVdj8RAJiGDHmvK
         UD2oViu/lwxQkFMkqXsFb5oxsbSex4AG0KLogtkbtUc9CxIP1h9llxVlMqq85yFEPqzH
         /4hIgRF+Mm/un5ri9mfReyJ3vBlXweVCmhRiFezq0JMv1w3ZYdSccIf3eXvojpKp3Hc+
         y2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        fh=K8uXO/qSAG+HjVK9yrePgO1J6FT32MB89NqYh0/DhiU=;
        b=QnFDfvfL9aNtCxm4stnm8efEaa43lalqilJg3tERbeHPAn8LC5BsfyzSlbqWqZYhUQ
         U2WwNvjSYGFuLbZtsxOACS2WAifDEluQ7q57E/NLxnuFqIYTrgGPzKKi9PX17aOS2E6x
         T8mQdf5pXk2PFZojWk0CAdXHV4Wi9626YxEoj2adlA9k4xYl1b0x+G7WRRUlB0tnwm1X
         4BEg9zU3EwVRqCHeVfPyEQ25Zgara3iH3Zh27FHkj+poL68W4qMomQPCx9a4If9s1qQm
         F+/8FjRwQ+hFqHF91kBpjVKzSXSsvqv5MzEukZtDqLaYeKakvFFnkLp7fColzssen8FM
         xZLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456072; x=1786060872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=lk/DigPlxuCIVbt879jIb6r7+Nmnr5dRWu2ogJeOmjjYjmD3QHGH4CSuEKHKoWHdhn
         AkdVhyIiBI/9atob2UT3f3XBr+Gwe/XQr630TJhEO8Td2mvak+gSBnKOsvd7JDzA2BpU
         802CBeK1z42D9bofWzkflLi+NCEfsgwcPJc1UKLMxl36m5WuF7T4L4mzzcHfeuyeJuK9
         bcFgGVdoJvnrF2886wiECWyWlwHg9e0BOXhMICgDnf8EmkLNVlCKwPfyw6I5QEhArx2J
         SDVPl59nY1Z+PfLyQ5k11S2DmN7I7ltlCukpdmARMsRI6b57LbPsiay8XnUQ7GT7+xj7
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456072; x=1786060872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=ARIIQkE0iiAeW8ZEkQSsWAvcGJbxp4MtCeyIrw10JgaU9OK6iV9i18LcHLZ+HQ0Vd/
         NfbzIynwmKsFcOOLACF+e5fMZo0g6kAhBQDT+hPynPUWHvv6PUl/YGWzUNXVLQVqIjd1
         gLqtGPd3P4FyFHeTEWj+65rSSOaMlUr+bNXD2rIJycMl4FXEeWqK4nsTMoIzx7XmMaGV
         /4aAJ0unchypptVOjzr0VhrAa9BTXI+mwbxODyr65XB/5Oqoo8f1j2PSvSE7JlHgQ/sS
         4+vLe020KSNJTpBfu8ZfLupQLLDMLfJWx5udeOmsR+1t0EgdOR+mSLQJZ2q6C3gOfQPw
         3t0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpH7TX0OxIlYTanMWhQ9EiVAkdpD7k6lrir2KqtJ8p2XPCzU5eCDWkkn8vwH0E9Ao06ZD5XxDTid5BQuyrm685d+9EG0H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Vq2bzx6G5FyYFU/gbRaJFgPu/F7EqvGdIj4b7eU0z9ZD9aq6
	kYDJTn7dMRdgLIYljuVJD5iCAr75Ti8bKRJYYptr64By0gV8uBqazIPyBdVXv3inCpCAGXBhT84
	uBb12P63CWwW4whTTaBNvjnJ0s27UyZQ=
X-Gm-Gg: AR+sD1250NQZzncUPMLjM9vVExO7UzphkrNnPtamu/0DZnIvR+Z2v7suuESxjBpM+o2
	0EWbuguwebigGd6af+llxjywsEZGm/+PipNkVSyrim3QO1+94gXZTujelGQk4LexS3peiKK5ExV
	xiTrRxHnfTlC+wHS/8SfN3xIMJFvISJP5ApkAH4kZ7FPmOPd1D/zemu26ktRbgg8rRW9+XjJeIz
	2L8RkD18papmWIOTBOgQN1xb1D04KmFqCgBacMyriezaUhBx25cTLXMKDStJ+Am5rpt4Br1R26T
	eRHq2q9C3wJaAi6xAMI/7buxV+tr7gXawiUHfLX8krP0UuYGTAQZz57Q7D4iRii6yUAPVnN3DcE
	=
X-Received: by 2002:ac8:7d0c:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-52b4b005354mr130221cf.37.1785456071885; Thu, 30 Jul 2026
 17:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:01:00 -0400
X-Gm-Features: AUfX_mzzLAETGk0-GNkiDsgUNvOmEZOv-UFFgDdgdht4DdfS7DnllTiGk_VUitE
Message-ID: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Based on our discussion in the v5 patchset, I was expecting to see
> this under security/; did something happen, or was there some
> confusion?
>

Nothing happened, perhaps some confusion. I was basing the placement
off of Kumar's comment in v5:

> I don't think we should do that in v6 though. What you're describing affe=
cts all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

My take on this was, leave it in fs/ for now and then litigate the
placement of all of the fs-related kfuncs after bpf_init_inode_xattr
lands.

Happy to place this in security/ in v7, if that's preferred. Apologies
if I misread the thread.

-David
> --
> paul-moore.com
