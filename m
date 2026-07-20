Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FC388392
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571142; cv=pass; b=sFav+6tYUv9yj6duMFzWEVP7pcPC4XW+yb5J7JLdxPYSZ9TzA5fyKWrX2W89vgSNPHkU6ULV7zxv+IBT68B9jCRvUgnyGy8cbutnxxzdIE48TmZrOE5Rs6te1NxFNMvWEyH750IChBFa0KHzf30J3T22AqcjL+x2xxt7LaKHgr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571142; c=relaxed/simple;
	bh=1JX430VNbqj0hZ6Lzk0OOAcmh3W6k774gqZhhQCrP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd0ZVUAoP2KtKx8mAAmC5omdZHGcOt5wwaywHONueYF1FHOgXMO0aGrYBsZGhrIBh1vZlCKKM6dDLoB3PbyNh4uZowyRl4MTh/NsbEIGd7iC5iVe2KlzDFzzcWJAxAmk0zo1DOev0/THCUP2PImvQ/1YN7AF4Uh12Li5NDfWfyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLp4eZh; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLp4eZh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so43252055ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571141; cv=none;
        d=google.com; s=arc-20260327;
        b=pxqKd1jEfgyblmvnOciwkCECEWQONkpS188LNLcRUbanpXpm43StNMUUi6ty4AydmS
         ptEW9n6JRlFOGCdYbaoichQtG/QN9no7hOsHsucCyoHxO5dEP6D4xtMfUAt2tGz3IU2S
         qdxoGKheZCkK27uFyfiN4eqGMMFltLzsgLwpYulXk09t7dTExI/F7JB74p4w15hCMk17
         JycxWjKa5SjCbFDnhn6FFwJZjh7qF/ulzKJZ7VfKlwQsOOZ6HduAzcByVVCu+2XZh2FZ
         +/z2VqRX4RvE1WJoj6ffZVP74qy8m3nA2Gp5GLytRQuUsw8X7exySwBlpzT+dK8q6Uud
         oCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        fh=/8gRN9oKMawwmcyP9yVO/SQdYqT4yWWmsC+AhD8ZlZc=;
        b=JL3a9+aGHT0bgls6Ank/F6A8BnoLi8OAkDujLnIGdkL7e7HE3cJj3J8d/5CugP7NHB
         1J24YMVGz7iInXwSHwPuP7PBpxlMJykOtwdI1kW+sbpsDGNTu4LODscwYzgDIy1FQ9ZU
         uGQPaINOK/xlacGhMVoN4ZAHkLVUK+3p8dTfI1AFKkfVaWY3VazS/2PbLZaohYiLGVQd
         HWMkeOGUxE1KjjH00jhlM8A3raoa7GMByMo6Q5IJq62aCgVBn5U9I/JibW9WCEMPmRhU
         aeC0kqueiv9nXCSN6u2bUAn8vwcxoK9dQFUmKL5/VBi98f+k2SDTkBlmOLVz0UzUfpH+
         bjSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571141; x=1785175941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=KWLp4eZhCGEaAiHAaTC37TOMSNgeCcmI9tjMngAHzbisyIIl4DD9oLzg+2o95wMPsv
         hE6y6Jl2R+fRW6GE7j8EoS1lgNSWUYXfvXHSml+nSoWRFyXNmaPRqI3r+WomGDlOOfse
         KEN5FUQx/u367rVVi8P++/X65Pg7d86mfGno+CcG8y5Z4Ww7bl3cicaMvNnU94ZyGf31
         tgRqMiLTY80YuoEfpKD/fgdKKmmq0VGW5CPlyeiyORPA5gn6NnDOHFi3fY0LAKS55pS7
         zlCeCbqa0b/kzaq5RD9bgq2lWh1NGTSIzn4cGQvlFvEodoT9KXZhOkSsuPwxBpSCMOZq
         b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571141; x=1785175941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=c8WDfry6nsZ9yzRJeDbkhP0qxQpGoeI7n0+SoWlWTjyaB0nUwtphbWPKjrVTihVElb
         voKqf6rORJSJmRCeZSJ97/kSwS0M9v6qsUA+I8NpKmn+ohLL52IEPWl++t2y5+ToPXv6
         eIt65JV4itL0y5wYVp/o2tonlC/i9AofBWam55Xkel02fQt1NcCoMhN/zatVwtubgB7z
         S8yk7jVsZx5/PuZhhHz8nvKj1gKb3JBXoDK8W/DKJecqni2yWPv4rzGWuPvADMD44/JH
         Pm9yfjfXcQstHaWXzCoJDPEM2ncR81rwp+ptE8/hlPiHTfQWbBaAIuBS7+Ej/rr0QthM
         lE5g==
X-Forwarded-Encrypted: i=1; AHgh+RpXg86ecS+K7uYJ8fVgYcgSjHWYhv16gTHqDq2vvI+jaONSXPwT6ejKSyIuGrCJHXZkX8DW6nYPyBlHQWQVzUS0osf2Ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AsTG8aQ3u+7rP6QyCZUsjhKMEi+KhJKl84EusrSn+HAcV2Hu
	mlFQM57RKnb5vuwITLsSXAR5GMUL3ueCqjCEHmd0KPI4le7cuOw2YyJd4bPHAairfUvG2f6+zGM
	Zi/koVth+2KpeE4al+1P938nbZGE4+QE=
X-Gm-Gg: AR+sD13SXpcc9Mz/4cMTnfgQ8R/bWAVezcTX3IVdEr+wDQtdbsQE3DEM4qF5LXegY2S
	wfxQl5GxQCppl021nsGOczSlkVwhpi3b/RxJ9KI0hp5uzmP7LX+N9A9dBjS/JGbN4WttDJf9Pt4
	Q9dSgqq7YdRhWX3yts0gFuTSuhvAfdKygVs1yClOmoX9zH7IRJHP6uGOkmbN8dDOilkQnt+7Tk0
	/5FvKqoLK7Y0qcQdqvIjeJCZyR3jKIjpnTQbl9SbBzQPlNJ5ySDt7oRYG4QM5hoTnisCyu4d0eY
	Sm8gCbFe6kJCQRMX
X-Received: by 2002:a17:902:ea10:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2cf1f29ea6amr213030675ad.8.1784571140752; Mon, 20 Jul 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
In-Reply-To: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:12:06 -0400
X-Gm-Features: AUfX_mxSx6cvDqWkeZpCRVrryYfuXxFSwFH_5FN2Ivh39vzoR79SkwFUGoqzhZo
Message-ID: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
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

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function.
>
> If the BPF maintainers aren't willing to accept that, then we will all
> need to find another way.
>

Where this code lands doesn't matter to me, so I'll stay out of the
decision of where it lives.

If this kfunc goes to security/, would we also want to move eg
bpf_set_dentry_xattr similarly?

I'll roll v6 of this series meanwhile and we'll see what the BPF
maintainers say.
