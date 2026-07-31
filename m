Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9B36998C
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528454; cv=pass; b=TIy3O7BTHFUJXlX1XrS4ikxx7czwKS09O/Ad1ZIWC/mRoJ8II103PAbINBhzk5ZNeCse41e55+nvD4kWxEzhS6ahqBqCmLeKmMS2y1Hme8pr6hAfrsZ7zj250wba2TKmMQbo5mwW6fuo47LGuG/dLVEfHy9wT3No0Ozt+9s3ERQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528454; c=relaxed/simple;
	bh=HaZxmJqYx+9+QhSynH8AmDcWjKIvancPwzCQZQKd8SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3aFDzgLhzB1/lKYO6JzO+2lkfJKP0LjpqWvys8ClMwQ/wze46lkT8N69dH8E6EfsKK+Ab2icQkCVX7B6vZ3LsX6NAhwjalVvyD43/tO+4o2cI/eltKi+fsh+c01nRQSse+3YAOiw9Y9VsrfWp+tsUTsOGbdTYUmjs7DZ1b362M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NPlVNPEd; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NPlVNPEd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1347207b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528452; cv=none;
        d=google.com; s=arc-20260327;
        b=Rz5Q0/3nGF+zwnA+PBVzS+t8iiksll29Qdo+HYe4DZovlJAUySToGfwSyNvU97vTe3
         ixfSnCFjWxnudZ3EKldUkdF0sc2QacEuieUSGImTX602GV67TkrGgqBkkYpYG67St1lQ
         fNmrA8nXR1WZeAgVi+55S8gRb10+/UO7iwEldC72mzKkaoIotNqUX3SR3fZ/OmOMs+Yf
         rERxMMfiWGplEVrMerHeovY0x2APA1P95yNvuIS6MsBEeIzmPsWB4K9rhX1uFX87kX9F
         ggI+9R+EKfXkHu3/fTrgQgiwNC4aVYKFxzVIDkVnWl+BznbWAVBWJydlzAP7A7pYEe+r
         ALCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        fh=4J4xYZ8zrJB5H2cy1yAIo+M3eAqGYfnjGabz4JxRu10=;
        b=DI/774gZh/Idj3GlYfoKeAev2+Xs6v8N7HZmrip+rg2qTN581qsDSWIivIbIRALrEy
         tMNCczvyZULFthbxeF7XD4hpEuUjGIHdy6tgWtc9e1T+Ycw9U5RlTBY+H/Q0zLUIu6DS
         fEYaYWo2BCB4vCBqBZPUkXtu8C6TDB3azl9XDUW6GWtT+m2+3A4u+NCae5FxgsXzbysn
         NT+QB3ChXWIzFPLqfco808xAvFzKDszAn2Wl93KsHlh0IXWukWcH1vik8eVA6XPtEyNv
         RUtaalnLT4mvodhFd2KygklDqm3Cn0pBWW8wQs/QcdZR4tmv0cLPg9FuuxDaXIeCd+mE
         tyVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785528452; x=1786133252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=NPlVNPEdkpYXPJZFPwbxsaV60UpEogskvIjAU9EuMgFV1M1pdX30eUEMpNbcZd94b1
         2gRxZ3L7whZk6DM0OCU5ZE0mVe9F7l1VNH9e5D1dLNE3sapfOKBfrNlY2INCBYhaUU+D
         Qy1Pq0Ja2OghaPhJ5SD2MfpL2GfwXjc6A41eRM7Wh98mjqfHH7/FYowwpjUsLil1FBHa
         hktynS0v4DT82vvLWYbcGZiCfnJ6rBbK4zjySew1QGWe7DAEKDYewlDQqsklNKGmC0T1
         dOLfERsr1Ca8HHki5+fMgF87EdRPhNsNTZ2h2dVCEHY8YScFMiyAoVk66LKpMADwZxDn
         +GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528452; x=1786133252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=FHMDJjP75ozp56eStTbuyaB6SfUoZphXkN8YkUe41O2jZMstEaR7z6vtm3c3oh9WUG
         h3Hr94E/osw+g1DsAyoZSRMIWvsXJRJaVVf+0JT0WZNZJnca5s7L6ZDQg+/EOfmd6Gc/
         eak3KLFop6KIkG5Z0ofDmgm7jr2SfzMRakr+ZkmjyOu9PIpM4Davvz70c15M8RSTWWMX
         SEHBuqAjJt8z4UMPqPAjn+ebMEZzCDlP7vUUc5oFuiZK7dlF9WitcX9S9JdCgQjhezAQ
         +SPTY3VMKR4p7tDPC3L+xM9WAz2mIQV8u5TNvtz+gdKkmMF7j/5rqjTZtJxGGgh9cRJC
         3/3w==
X-Forwarded-Encrypted: i=1; AHgh+RogQ84l51VIX39AXFZyuPjMtw6x2M8LPzeus+RU1AriM71RMR3OBavNupklKxnowTHLlvRvArpjjJeek7Png7OZqlZPho4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklWmvxlhGPnwhGQEfimrbNgZ4uHLZWp5AHobundpCKmGBDYnC
	8CexWUBk28zm5ibcZzlfBrOvUFA5vQHHE8ACvTI10KpxH0d8twd/K47WtY4n/x56DQLn558A3qp
	OS7AuqaHw5awNU/R4dvp/HQ8fqFeyMleHB2+cgcOJ
X-Gm-Gg: AR+sD13w9C2y6Fe6MduGnik1pBane7Eg2ybZtZQshncQcvWGhOT+mKsWurbeW+zylv/
	lv2yXNhkKC9pP72O0bKn03QLkMzoqq1MVSOOZPtp4Dfps/dglWVgGXH+hSZxXP0POj31FrqRZiU
	yby7SQ6S5wc+7kPhK4D/xuFCueLvRSX2tC27INfhgYpP2uxU3aH353ej1c6KoImxp3F2faD7JrA
	fS2k8X4WoJwPTwEgSUqqBsQXkCFdgNtnFUcvmpJ0CVTCLDOL4nJJZh1Nd+w8EvBxfnjBXdst9FR
	/XR+plhLhhDxvMYkuNTf78v/EZRqXa7YSYpo5KClnbpOBeEm4Yi/6QI=
X-Received: by 2002:a05:6a00:9094:b0:847:7a61:e68e with SMTP id
 d2e1a72fcca58-84ee482cf83mr862916b3a.31.1785528452555; Fri, 31 Jul 2026
 13:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:07:20 -0400
X-Gm-Features: AUfX_mwbFUF3u9BOCn6R0bUcxbx1dq-jZz_UTL6QyKSEwU_IdbxDl3CNhAP30WA
Message-ID: <CAHC9VhR8RpkP-N4J0wGbv167NctjFTOg5Z+n4_M0pjp3Fbnamw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Jul 31, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> ...

Completely unrelated to everything else in this thread, does anyone
reading this know if Matt Bobrowski is still at Google?  I've been
getting bounces on his @google.com address for a few weeks now, I'm
assuming others have as well?  If anyone is still in touch with Matt,
can you ask him to update his address in MAINTAINERS?  Failing that,
can we at least remove his email from MAINTAINERS (feel free to leave
his name if possible?) so we don't keep getting bounces on postings?

[NOTE: for obvious reasons I dropped Matt's address from this email]

--=20
paul-moore.com
