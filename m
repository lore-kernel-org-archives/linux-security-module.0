Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF631AE087
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894929; cv=none; b=BbxpYUmV0n1McalzBIcQpu9iO5NYY896zWflbjyjcoUlHF392Q88DLv8aHp1mJBgEnScgyq9XfKdlhZ/agRgPDlefWsmLEKLoxdd9v8BlzT+xzRBcd2Ldg7ScyWa1j3Jqky5nmyWAJAfqvFEqXCKUeAx9OXtIKwFUsgTJUs48WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894929; c=relaxed/simple;
	bh=ZWkJZNR2bxEM6LA73IvJZfOwKaypUz3ChIAu4T7npaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iodiynNVxBC4xmPJj2UbbfCgifW0ZCIOdTl4Rf+w9t95NemPdtF3rBSwsvr8XrEpDlskqjEkP38WmVh1YL94Vfz6v4F4OGlQl0oJOoujvIlogLNrkhlmTz9rgvDvxscbvSnzjHa31hev/4p6bi+0s+aeiXSBZi9rTeWHf6/5anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B8xFZOZt; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B8xFZOZt"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-63ba688bdc9so9619587b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718894927; x=1719499727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2Ix8vRkDYAbIzLofJN03PlLvyWp4g34uNnV/Zr5cQo=;
        b=B8xFZOZt8jPqgy49CCh+db03r8W/X2N/3Hduxw02AQet6Ndo8rbrygpiB3VVOLxYVY
         LVeJ9j71pXht2slK/ht1eJyvN0M1c3bVEPtmr1cfO68+l9eH3etCSrLR34M+UYgkGWax
         dmWIH16RPNPJLHhH5CzWD/qzZTMdOdOhOp3xnfQZVDmE+jTuk0NZAPsFzaJW2zrxrMhm
         lIh3re0UejijpFlzuci5Z7eo3lvzl7LrG9PyKVaRCY6rFkcYXYrdxnzlnF9VQaxzWs4+
         aeVytPtwcm8tXgnGoBdfSpIgwGgenHHfAbopMf57nuLDqft161bwWlbdPTBF9YwA6XMx
         mVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894927; x=1719499727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2Ix8vRkDYAbIzLofJN03PlLvyWp4g34uNnV/Zr5cQo=;
        b=TijE8YFw07F1AGxZP230vzAbHOnhMJxlxVLhk0RZ+skS4QD24hCraASe5eg+4Knqwu
         8W/mPIlTfPNr6KVruKNHyD0VLOc0hnVC3fQ4EyR/fzbxmsMUW3/HWdxisSuCndrXqPQe
         GGI6Th9M9jhIECHqGC26U5gzkg7WcDJO+h3MzlVfDwRlxQdUW5fSxAdbt0Aw4fVjg2A3
         qp/l1If+YUvZE8ALe9hk81PBMvLuC4NupF2754IxxGZ4tGmU6hL5nhkv3vHmpNBnVT3Y
         51FSuRCB4hr3r1eAPBvA9W/eOZHx0A0ud4UtRpDgQbJDhl8n8g6AHexS0lrHVhA1PHNw
         4Nfg==
X-Forwarded-Encrypted: i=1; AJvYcCUzaCkKhyLVn8I71chj0x5QPXaRHjmQWEeIb8MEF7K0LgT/SO2NN9MvoRZ/fSdJ2ucwWBmP4HjAGSwysHa6Ct1N1C5EFlw1G/UZFPasYkMDwFzaGgW7
X-Gm-Message-State: AOJu0YzFa+psTbFEf4fAdHH0sUx2eQNex6JXGKZRzsuxzMqzYNbVbBK9
	qZpL3kjcKHro3yeR8/79kjR/ejZI+m0t+aNzElnHbqPkZ8UdMk6tIZyoCPQfkR2EXZgAJkCMu+l
	h3hO7I0Va/+6SCnRnxGIalHJjG/hDm8Fi043O
X-Google-Smtp-Source: AGHT+IFuiJSlu6ok/X5AbetO8OQ5D7Cz21KHbzk+IA9kRhrNMOU3OFyVB6D+lstQN8v9cNDF9o7/AysNWhm9yCWP10k=
X-Received: by 2002:a0d:e614:0:b0:632:6615:3d67 with SMTP id
 00721157ae682-63a8d25c8e4mr59092877b3.6.1718894927304; Thu, 20 Jun 2024
 07:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com> <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
In-Reply-To: <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 10:48:36 -0400
Message-ID: <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Making it a kernel subsystem would likely mean replicating what the L=
SM
> > > infrastructure is doing, inode (security) blob and being notified abo=
ut
> > > file/directory changes.
> >
> > Just because the LSM framework can be used for something, perhaps it
> > even makes the implementation easier, it doesn't mean the framework
> > should be used for everything.
>
> It is supporting 3 LSMs: IMA, IPE and BPF LSM.
>
> That makes it a clear target for the security subsystem, and as you
> suggested to start for IMA, if other kernel subsystems require them, we
> can make it as an independent subsystem.

Have you discussed the file digest cache functionality with either the
IPE or BPF LSM maintainers?  While digest_cache may support these
LSMs, I don't recall seeing any comments from the other LSM
developers; if you are going to advocate for this as something outside
of IMA, it would be good to see a show of support for the other LSMs.

--=20
paul-moore.com
