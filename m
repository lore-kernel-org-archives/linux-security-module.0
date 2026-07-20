Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801E442134
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572042; cv=none; b=gdiy35tSluD6aTmvKVdbHY/ybgXXPRPxykSTxReybWKqw6Co3iKI596porntYgZMOvba+NeHJBKTPwiINg7GN3cjUKmktHvXQjOj49WIv9JuMaypWKyJSqVe4w4uEXcBrW5qeEn2W0JGtNwBEQRBS63ooX+ymWGwJlg9ij0O/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572042; c=relaxed/simple;
	bh=HaKBPDdvqD3jL+crpoeSpqk4rCYr9G1sp8Bvlz+sMGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QWJOOlp7dNeMjJ0/D8gJuXKLOhYnX+poDHPdDGEkt2dt8B2lejKeCCs7bBKSNJ4M2NAMDVHKP3k47YAgu5pOLUXk39ssw4bIUYVl1uzYrtQ1J77gmERuofTLW5SrWnwBqqP38NbsWNcspg56IienXenljS0yZShOYua422eFFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0xzQg45; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0xzQg45"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4731c03ab71so3421459f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572039; x=1785176839; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4BSD6EaevsT9Fl/VQOSMyXi/kGr0zB0+ZQdJSCGrj20=;
        b=s0xzQg45ODMjIkrBxaOW/KlxKiRtUAz2Bi8N3AspgUHh9RvnAN0zeXcz3yZ9VikHTI
         eAxZ3lafL10cuAoICpdOm0p0TbshlDVBxfCkdnoi4Xw6K8r2diMtvsZ0EW58qfZBcU66
         pgeR+MPFIBT3nQI4QADwxyYU7TDAhpwLYV9GRHyQ9UlgRgr6np4QNy64LpxnLmaQulQL
         6NIvWJvGYr2/Nllw1SJVB1u3kh5AH5cFtMTWGDHdtq0zrU4GdeGD+/yIuKIenCz7KCDo
         SUZaLmOvV09kA+v4dJw1pugxwWwm2YjE3x7FX2Wm0Rx/0wu/Fl85s/BjVIwVb0DcTVTU
         AyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572039; x=1785176839;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BSD6EaevsT9Fl/VQOSMyXi/kGr0zB0+ZQdJSCGrj20=;
        b=BnmxPhYKKBb79F1is6+Ix/J4ZZSBcQ8MfkzrlLxSGtIIYi/Qn4dhLm3jtPm5vGcbTf
         a04DrJZ7lTBmdHXg5DH/M+htFkN4dunJth3rU4D34zIwKUNcPBCfz09+eMi0nJXJjliV
         zcAUQhXSFjoYtUMmMPe70REgmDN375DG4+hltxx0N8/fcNdmk2uQAQRKbQ2cE+Gl7XB8
         oElhcDBk0fn1vj78zXzLqv0ESGFhRZ4WqSF5FFJV9ENNfbzvgN6bTJZwdfZIl3TlFp1B
         YJmNSNgivkLYYANFXmErYo8rMg6tuD43Nf5US22lvyJcD4noG9d/4F3L8TuhXHimof9O
         ONHQ==
X-Forwarded-Encrypted: i=1; AHgh+RroaEUZseduZCOJw6G3N2Y3uCCD7cpS2xd94pX1kUsUU67iyxKn3SVLzykSuZGqA3XkIv5Bx65mu+kBHu1p2l/FOmgM82I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxf4TTfZc9bAu4OHDIVmEnBmJX/wArvH6u7j/T0IaFwcsonDn
	2kqJjgepmmnb6yWIVFG9bYDdepazfSXaI6DfdrIShyk1csmdBEw8o5Md
X-Gm-Gg: AR+sD13Pjo/btSCPnSWMjILUIYGW0Oxw5o0LC0+CQygrTa6p6ycUGQoVGkRoObfSoky
	678WyavrLfbOEN6qx2E3I1dtN3K9XUjQ54QfWOjxm1ik9Uv4gLb+jZ9gJpT2Mz3rE168ukEi2eW
	H8PRttnypUoZwEGiDzh2fqVwfV8Y/EA/QShI5Fs0E58aB3muMiVekUhXKQIN9ORf5PQtNlJr35X
	5X8pU33sjP51N8z7YA86xHfMbh29t1mid60vhyxD90c0hIrizFYkZA06i9XbuW9zb7gw9oJPQik
	aBr/cTKYP8ParExxowWnK/jS/lc2MhsUQ8lwk3FtohUe7cu0ejG/FM3xYpzfInaCZw/YLJ9XS7s
	LJwAEO+G7o21nTUdhgGapVbrifbB7WUfkv1xUyp0+s8ARzlIgsqVoSZMK6kY+7lm2PaUV8yjl1k
	idM43MIT8FkaQ4kQT9mJpvTOYCz+gvurC2HmGtR3Ph9JVO8noe+TDbELH1nizub6V5861DegiaT
	lmEx52NwSYgHx744c8Dp523NkDbICi3qav88LGlCVz2
X-Received: by 2002:adf:e195:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-47f623364bfmr18309880f8f.37.1784572038601;
        Mon, 20 Jul 2026 11:27:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm30464561f8f.16.2026.07.20.11.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:27:17 +0200
Message-Id: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "James Morris"
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-3-dwindsor@gmail.com>
 <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
In-Reply-To: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>

On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>>
>>
>> I'm sorry David, now that I'm seeing this function again, especially
>> with the LSM specific bits extracted into a LSM function, this absolutel=
y
>> belongs somewhere under security/.  It's only callable from within a
>> BPF LSM callback and all it does outside of some BPF pointer boilerplate
>> is call right back into a LSM helper function.
>>
>> If the BPF maintainers aren't willing to accept that, then we will all
>> need to find another way.
>>
>
> Where this code lands doesn't matter to me, so I'll stay out of the
> decision of where it lives.
>
> If this kfunc goes to security/, would we also want to move eg
> bpf_set_dentry_xattr similarly?
>
> I'll roll v6 of this series meanwhile and we'll see what the BPF
> maintainers say.

I don't think there was any preference expressed from the BPF side. Logical=
ly,
one cannot be faulted for adding a kfunc to set the xattr for inode in the =
same
file where similar kfuncs to set xattr on other FS objects / entities exist=
.

The question about bpf_set_dentry_xattr is thus valid.

Anyway, I will leave it to Paul and Christian to decide between themselves =
where
it makes most sense for this one to live.
