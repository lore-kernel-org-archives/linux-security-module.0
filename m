Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0621FF41
	for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652066; cv=none; b=TCRqPhx0tOs3C1YriPvaoqDT2u5B7OnXWhQFEVPzEoPJimgJnI2BBuyTIavVcU2B3VO8szorAe2rolq0cJqV63BV7kgmvny8SHW61wx6qcchKkTYaqkqosZkrdvPnQVvU8OwW/fsOTm5WHPVMt6fJ8DRYazvm6Trh+46bZZhq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652066; c=relaxed/simple;
	bh=xe+NhIdEtxHmjm8xKeTWO4uHKEZpiSROQTAIPoHNfLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q30JNsi3PcH1fMwqYt8N0fZS/nrFbnn7ywO1za8zi58Ffg6C4ZUQzokuvE6YhNKKViFWolP7shXzN8T1hvrlSCpGZQMUWb3yRTJs1b9Rfg8D7mQFDnf3e8pWaHG1YYIAnl4ihBWZ4s/dp715A39rAuGSNFT3fvLc3YsrlwTB95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAzl8d9i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAzl8d9i"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f7469so9298095e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Oct 2025 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760652061; x=1761256861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1m5oh/C2ya5fQFeC4TaY27qKH8o+UGJB/7+qbAmZI=;
        b=CAzl8d9ijSTZT6yca5qFmjZ/CflinBT1zNNYI8WJ0DFV5PPFObRsDvPHGoUL1q8yPM
         9IMbu5hb1oIKhIRWjjFJHWmHsttphYow+oZ8/95+mmZi9zPgHTZfwgJ4avglc1vbZBe7
         1PtOL7aOdc3ShYneXOPlEbiCue8UGrEJFMYhc/OGr58MQLm6JGUAIQoXUcKQ9+uvL2Z7
         ydnXiRMmgwhRz1KA3bfP7qUgvtZtaqVP9M5lqxTXiq523xwLt+stJRNVlEBR4CeZ3QPi
         es9+24YO1nkjekXG559Ev5o+Ym6btqS/FUolB3p2MmDPl1+gvKas3jq+Dms12Tk4aMRy
         SF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652061; x=1761256861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1m5oh/C2ya5fQFeC4TaY27qKH8o+UGJB/7+qbAmZI=;
        b=IG8F3io46yvAzER6iyhMqb98be1olbklzifRfcNR7m+iFSJ1BZW7AyVyzfibpyvkTh
         XmtFIkv2ZY1Uph4WEBNIALOBYds/qD9CvK/QXs57bNWM2+6IZRgr7/z59ea/7Szv7CqH
         DcJKTa97Io4EdnXVW4fCYTWz+sAmF3TcIZ+gSNC1AeumSPXPrgtJGwdB91+xMwM1Owol
         2jbhhZmqYWSfgj/UmeDTTsbMpMBnisE6UArBc9TA6izbr4lWW/FnEcDlA+BaFmuC6ef5
         2bfIxwf3eXgytTOdZwDHoyo8vVHAoWcXS7iYAuH6cFdua/Bx7MlWKDRcaY/VnWMIzg9X
         8zfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKKMszdtaSV0+8HyOmAK4ISICG0ARslqyXpvBjCjr7R1eFzSiEGG1cv1i7ZWjqr+hpylG9WTR96NNm9ZoP9P9KcrndOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47vFPQYJfRv7JQTANZ6sc+8WciyVUaDLEtC9RTtbe5asL0fDf
	yLDqV0g4KFgmoVHEpKsAfzss5BaIu/eIfEZCLk1S7S4GdImgGb3avDBoGfHra9J+A56A0+5KIqu
	5O1jguBJBNRvN2hR8Lqqlvh8f833ZlIQ=
X-Gm-Gg: ASbGncvi+x5XgjqCZOg3KcCNSgUmc5Th2kRpXVRcrffA0W3Ym4Ul+AZXOfznZweP7f0
	Yhb+fZ1EpGd5lLNxhTV2GtVj3e8xpl+5jmTn+x6RnW/iRAopxVlgmF6fYVJg39ygxxE4M9Dm3/9
	tLf65nmEK5C5sGaz32JwnZ1bhh8y96J21lMsLFpLE3EwcE4YY/FVXYuqJIXfsp1aDsTpgWj6T+L
	DM6kr4rIAqqLwh0tqMxZM9nkPQEM9UDaXS56mIAf8C8RVRWSHutcXVt6TzkqAwE5RGU374SghGz
	hP4ozcBaUR5EiLtfAw4Of55PBOsl
X-Google-Smtp-Source: AGHT+IHbckAP3ar0ENCksvvYMo69hZUNmT2OQZntJCuLluBEpqZzCD99uKlti0PkUVTDNjC56Tqj5+4gtBrE/tA0m6w=
X-Received: by 2002:a05:6000:184d:b0:3e7:5f26:f1e8 with SMTP id
 ffacd0b85a97d-42704d9cfefmr1186928f8f.5.1760652060968; Thu, 16 Oct 2025
 15:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com>
 <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
 <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
 <fe538d3d723b161ee5354bb2de8e3a2ac7cf8255.camel@HansenPartnership.com>
 <CAHC9VhSU0UCHW9ApHsVQLX9ar6jTEfAW4b4bBi5-fbbsOaashg@mail.gmail.com> <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
In-Reply-To: <CAHC9VhTvxgufmxHZFBd023xgkOyp9Cmq-hA-Gv8sJF1xYQBFSA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 16 Oct 2025 15:00:49 -0700
X-Gm-Features: AS18NWCHYVxF7GSfIutVNDKmCB7FqGua0rnVce6zETEX8aqYgOptdQU3tKPf6ho
Message-ID: <CAADnVQJw_B-T6=TauUdyMLOxcfMDZ1hdHUFVnk59NmeWDBnEtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Oct 12, 2025 at 10:12=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Sat, Oct 11, 2025 at 1:09=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Sat, 2025-10-11 at 09:31 -0700, Alexei Starovoitov wrote:
> > > > On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > It doesn't need to, once we check both the loader and the map, th=
e
> > > > > integrity is verified and the loader can be trusted to run and
> > > > > relocate the map into the bpf program
> > > >
> > > > You should read KP's cover letter again and then research trusted
> > > > hash chains. Here is a quote from the first googled link:
> > > >
> > > > "A trusted hash chain is a cryptographic process used to verify the
> > > > integrity and authenticity of data by creating a sequence of hash
> > > > values, where each hash is linked to the next".
> > > >
> > > > In addition KP's algorithm was vetted by various security teams.
> > > > There is nothing novel here. It's a classic algorithm used
> > > > to verify integrity and that's what was implemented.
> > >
> > > Both KP and Blaise's patch sets are implementations of trusted hash
> > > chains.  The security argument isn't about whether the hash chain
> > > algorithm works, it's about where, in relation to the LSM hook, the
> > > hash chain verification completes.

Not true. Blaise's patch is a trusted hash chain denial.

> >
> > Alexei, considering the discussion from the past few days, and the
> > responses to all of your objections, I'm not seeing a clear reason why
> > you are opposed to sending Blaise's patchset up to Linus.  What is
> > preventing you from sending Blaise's patch up to Linus?
>
> With the merge window behind us, and the link tag discussion winding
> down ;) , I thought it might be worthwhile to bubble this thread back
> up to the top of everyone's inbox.

Please stop this spam. The reasons for rejection were explained
multiple times.
