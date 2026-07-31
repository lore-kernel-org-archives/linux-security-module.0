Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FE456295
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515538; cv=none; b=eVd3CtLDDUuzlSFR6KWB1WAHXY+ShedXcfs4aCmFFP1/7OwbbRQQJwuQkmSUwk0+FNv8Vs2l/e7g7avNbt4YYKinPaKnOAjEYkN7fXQtpxR/BNu7MG3IQ2Q58cqQELu5SGoink8QUraa/uZIyHd1+2hQx5PZrI9SfDByU3rO0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515538; c=relaxed/simple;
	bh=9HFGiNNNAUH+NXm19RvmGJwmOISH+nDndQe11ccbYuw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hqgkxrY65h7W6UF+FpcQvK+RCsIMTls9jhxmGHU9fR1S9YvM5+gwJefAfdF2kHk4Mt2k1hISKArtrNWIVty+0Pvyqe4hTi4UOSe4+oXZjIGYhbI8Re2Fo+gq0iOtPrpssffJ8BFMs4Ap2AIxpHFyEv94gsG1YqIfzJTlXw9K/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq2ri5FP; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq2ri5FP"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef3fd4so48551f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515534; x=1786120334; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aUmR71V4eGCOh/F9b0SbwQJJGIMeqY66EO2STeKizkI=;
        b=Yq2ri5FPbQJ1F4uB/eXjU4yL6HWzrOTKf9c4Xq+kZsfcpu/XGsIrybdMN3YrtEJTKj
         goum9m7pj2R3M8ivlQ+VDMbDwl0OzIB3a1qavcLW97XEHUsv5K4woOUpGv/iSOuygqhh
         xhhGtT1l3wudfOMd/gYJYeox1zanwTegbFoe9CDDbokmy5HkjZVDv5+HMu8OXQwxtkVM
         VY7jxXSHg8kyEVizv7FOJfqgtA9IwI6Af3RuOXdG5pt2WLXvkUcWKchb0Al2Ogs3QLvb
         g/0tL/nwbmvLoQ+6/ao19dheXt0N4EVK6p57+Qmg9JDSjKXQeirDl1nnuiiYVF71e7db
         p4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515534; x=1786120334;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUmR71V4eGCOh/F9b0SbwQJJGIMeqY66EO2STeKizkI=;
        b=fw0u6ohgGEowb00rmIaUqxISKgQX4jEffvYPXttcw2gAjfS6d0+SSxxkS4u3541avX
         Z4cTUcTJCyVxQION11Bo8qgtlUKDPhCxwlz5piSxMmjcPepyQmE6Q7RPfSHteqc51Jwj
         5Z7ONRW/Hm4xtVbk7RxqpRWcNyiWFzFSpRtt4HZIhykvDIQtZvCFuwrXvXyBRxTairH2
         QosnEQsGGpNl0oiuBorhHV8YIf1SSBYZ7i734G5xrr5wJ84ZWoSFGrH8Vk7aNrwFlz9R
         JV79E5fnwQSqiJF8SOCtt+L1yCPMNGVTs7Yq8oaqJdeJ2HXUMinX9wAWBXI9jRqsC5/4
         Tvcg==
X-Forwarded-Encrypted: i=1; AHgh+Rq17Gn7nmbcmfwy2yZiZ7BTDN3a5Uu4n6lONvhaiwvfZd14JI2l28iSdTpkM190KYnwnaQsWk8FoVgiKE3w8hIFKXLZOS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQupwDfDTUK117ZQIpw1jou7jSAAXGckJDr5pVerejaE5m0loG
	EYcOWp6Lyu8JjFUzmfNoi5qm9e4U7OB1VHdalE7ecV9YBeaq3d0d0xZH
X-Gm-Gg: AR+sD12peTINnBLt3gbpHX1nHCXIiKyvZh9rF3clv1s5JFMZ4ztq/DZmfD+DMVgXd3M
	BuGosapR16iTipk7WS56TAjG42hdxV6RJcPQ4CD/lthqlmjRNZWgPLojVxDIA9PI510V5BeIum5
	3KSD+qhQkqx1NIJYl7MNCRil2etRnzxIE8BhXSxMlFaAea9gE9q3B3tj7iPFbRrvnbtg9IXPW48
	8f3VSNhZNsdF19zoqTfS5J38yKPzEFqv54L5ZliUuJVO2XcLMEMJEK9KLcqDG7Skk9QByYHmNJ+
	WLWRs3kYRrELSuAYl7aiZAwYmrsj0LR4r3jN5jpwFmyqTdwcX8t8IbHL9dXlBVplG4FqtVCXEn/
	RlfOWawWWKwmveUOjDkDs7fQGMo9RzzFekeYDQPzS35g8gedP/whCn5Bfhk/xv9py78YZxJGppz
	yvaK3nVJbQuwRUPxZJz/PkCbPMUgN9G+UXQ8sTOUv10pWpVqC3poN8FFub6qgD2DkgbcAsSA+VI
	dIIgpiWvihUy9FMNtnRNdOdmTE0owp8Rzr/NkCUE/7iqqRrww2ROOVW3fhhYlTTAHpR4SdWipSA
	P/CcxsLVxkcCwqoiQHdARj88IUs=
X-Received: by 2002:a05:6000:481e:b0:47f:8cd3:4bed with SMTP id ffacd0b85a97d-47fd725b19fmr763298f8f.5.1785515534056;
        Fri, 31 Jul 2026 09:32:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm6524909f8f.12.2026.07.31.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:32:13 +0200
Message-Id: <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
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
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>

On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
>> >>
>> >>
>> >> Okay, it looks like there was some confusion/misunderstanding.
>> >>
>> >> My understanding of Kumar's comments was that he was referring to the
>> >> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
>> >> not necessarily the new kfunc you are proposing in this patchset.
>> >> Kumar is welcome to correct either one or both of us, if we read that
>> >> wrong :)
>> >>
>> >
>> > Yes, after another reading, that does appear to be the case =3D).
>> >
>> > We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>> >
>>
>> Since there is confusion, let me clear it up.
>>
>> I meant it for all of them. I don't think it makes sense to keep this on=
e in
>> security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo st=
ate is
>> worse than just placing it where others already are.
>>
>> As I already said, the discussion around whether all of them they should=
 go in
>> security/ is orthogonal and should be done separately; it isn't producti=
ve to
>> repeatedly bring it up in the context of this patch set.
>>
>> I honestly don't get the urgency; it will be a mechanical change if we n=
eed to
>> make such changes. The worst outcome would be stalling David's work over=
 it.
>>
>> As for landing this stuff, we can let Paul take the patches touching sec=
urity/
>> and route the rest (3-4) through bpf-next after the merge window. We nee=
d them
>> to go through BPF CI anyway to ensure nothing breaks.
>
> Some existing LSM kfuncs are located in the wrong files.  I'm not
> suggesting that David needs to fix the existing problems, but there is
> no reason to keep making the same mistakes.  The new LSM kfunc must go
> in security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF
> developers then David will need to find a new way that doesn't involve
> kfuncs.

What "mistakes"? Really? It's just code organization bureaucracy. Calling i=
t a
mistake is just blowing things out of proportion.

I don't think you can simply decide this unilaterally either. Do you take f=
ull
responsibility that kfuncs going there won't introduce BPF side regressions=
? Who
makes sure patches touching the new location run through BPF CI? All of thi=
s
needs to be thought through before we decide upon anything.

Thus, I am simply asking you to be reasonable: let's help David make progre=
ss,
and get the changes landed. FS, BPF, and LSM folks can then decide on where=
 to
copy paste the existing kfuncs later.

So David, please send the v7 once you've address Sashiko's concern. We are
almost there, and you've been at it for a long time.
