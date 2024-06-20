Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE361B1411
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899739; cv=none; b=BerIJ1RxezKACpn17kwRgBcLKPHJ5XjKFK974YvK3VLR4Ce2NbsPNgLWh3QcfNU4z1gCy/0LDM73MoqnrJx9tkTdqcAsMVtnj2elFplEzl0xBaGErjp7557zFx0ICzmpRFPdg1Gjch2xADRSoRdFHmbrFh60QiD/S6ubZd5fM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899739; c=relaxed/simple;
	bh=jKOKhzCb/s1qR2kIGMCwfAQ0zH++nCz+I3VwV8UWtwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfpP5XJy/r74yKSjkhNQqBo1/pfgd1f9kNGM5pQ9SJ0Ud5BsVEuTRzHTYkIF/ueSTE0jAVhTATlgNiimHxn6J3SENZypJSFmNRriy3BXCFkrZRoCrMbgcC2EeK8njlK9NdVxFlCwnUwFW7Sf3iYbKfgOUZzaHeUkiI4GCw7z6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SmQnNKYU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SmQnNKYU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a08092c4dso10884277b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718899736; x=1719504536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ4/HE33CH2Jns1MFWm0ZR7t5r4f1OMGqj8nTkihE70=;
        b=SmQnNKYUz0J+LWkhP3ayIphOmx0E12zK437aHpbtGmblipl5FTe/Bv0cVS1syhPnzZ
         ritvPxHvF8Tu344XouOlrjBBar3LwrRY4+ClqTtWms0FljQzUFm/fJ9SMOJjk5+J2IGN
         lJaaWm5sDS+qoFQSYcfhZh49ZMNZ5vMP/jn7PckCphmDOymeuQ3HmY+jxoJiSyGWEo4J
         YQQ0w2ioASC4AorOxnIl9ykOZQD8F7GEgSwdPA2z8wbWRLREZhaODO+cepFUzo3+DuBY
         QDNcG2dHYGQ4tbGJTzYya07OzHK9ZRVx6fUYAVSzljTPjhyVBIg2YaYdoG12kYXbLxwh
         mncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899736; x=1719504536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ4/HE33CH2Jns1MFWm0ZR7t5r4f1OMGqj8nTkihE70=;
        b=m3fWWoxwwxHbUesXflPosc81gdHHNgTdN7gzjEzNH97uHNUJPnNWJb9+vEH1pzMR43
         HLLlYPAXIwd+tgMlLP46lVJGiqauSrqkV9F+JF4JMVRWHXEZWhciARcOdCDqpuOxBBO6
         TP1f89eC/CLGAEqPOe8lVR93ODor7dEVYqv7DD79ikOag8WyDqdojHCtsEGphyL2JkRZ
         HvWW9JJ5/xC8M6Ygr0cJ/HiMVg3/WYTRAwq8xIPAA402J6mGxrv5dNLST7L5jxl7CLr/
         11umo8GHkMjf8klNYUuSTKVUuhXNBIUcMcYb5pDlEiDPrs5et0vs3n76XsbcJ3RsOoUm
         IXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWDVvTAuFbgESRTtSNQmSAAvWjz3jwGSWgN9DFscD6fx7YRy0DBF1QiU1BMbSUEMBkYdNuHdmaQO7NLdnCgH4wjCYcmYmFKi+IPxLxuPBBE6kZ19PF4
X-Gm-Message-State: AOJu0YxlPnD+d+DlHtFUaOn1kND+IiyA6z8zhRHALGi7m/ez4VZp43AZ
	7RyWkWoisr8F7muqKxLz4PB47bjgUMWzzoDrv+RGcZ/DEy+lWbKxxz+K1Mot+ZXLy/aSVNJwZyo
	WDKIEBgYcFSDkXRaYNXWmeVaKhYknldS0VxoUXoRbG1t4u/J8kA==
X-Google-Smtp-Source: AGHT+IEJD8llzQZDQm0N+h/SilvZaX1H4grLcrBULEvzCzsoMDLOV0byMoHIPLcWuG2L/HTPdx4UkXvFsIa166iHKFg=
X-Received: by 2002:a25:9c87:0:b0:dff:2ce8:cc1b with SMTP id
 3f1490d57ef6-e02be19ffc7mr5879084276.35.1718899736547; Thu, 20 Jun 2024
 09:08:56 -0700 (PDT)
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
 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com>
 <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
 <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com> <c96db3ab0aec6586b6d55c3055e7eb9fea6bf4e3.camel@huaweicloud.com>
In-Reply-To: <c96db3ab0aec6586b6d55c3055e7eb9fea6bf4e3.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 12:08:45 -0400
Message-ID: <CAHC9VhSQOiC9t0qk10Lg3o6eAFdrR2QFLvCn1h2EP+P+AgdSbw@mail.gmail.com>
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

On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > >
> > > > > Making it a kernel subsystem would likely mean replicating what t=
he LSM
> > > > > infrastructure is doing, inode (security) blob and being notified=
 about
> > > > > file/directory changes.
> > > >
> > > > Just because the LSM framework can be used for something, perhaps i=
t
> > > > even makes the implementation easier, it doesn't mean the framework
> > > > should be used for everything.
> > >
> > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > >
> > > That makes it a clear target for the security subsystem, and as you
> > > suggested to start for IMA, if other kernel subsystems require them, =
we
> > > can make it as an independent subsystem.
> >
> > Have you discussed the file digest cache functionality with either the
> > IPE or BPF LSM maintainers?  While digest_cache may support these
>
> Well, yes. I was in a discussion since long time ago with Deven and
> Fan. The digest_cache LSM is listed in the Use Case section of the IPE
> cover letter:
>
> https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-send-email=
-wufan@linux.microsoft.com/

I would hope to see more than one sentence casually mentioning that
there might be some integration in the future.

> I also developed an IPE module back in the DIGLIM days:
>
> https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500a987121@=
huawei.com/

That looks like more of an fs-verity integration to me.  Yes, of
course there would be IPE changes to accept a signature/digest from a
digest cache, but that should be minor.

> As for eBPF, I just need to make the digest_cache LSM API callable by
> eBPF programs, very likely not requiring any change on the eBPF
> infrastructure itself.

That's great, but it would be good to hear from KP and any other BPF
LSM devs that this would be desirable.

I still believe that this is something that should live as a service
outside of the LSM.

--=20
paul-moore.com
