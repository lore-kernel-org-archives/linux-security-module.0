Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C73D7D94
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696484; cv=pass; b=jyvFF8GrE3YVf4PecAHopnndM5fNbhzFg38jwLG1de8OP7L0n7ZT3iAouDUBQfiAtosKcCDXyzVfDt5qCPlQJ++RW2jY7FyBpMnlj7qkcyMWl67PIsTaPwqH3GS0Sc6IIRRGCY2kiCOr7D/2JwHcfbcFZncb0tD3Ls38ulH6GXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696484; c=relaxed/simple;
	bh=Ff6kC5hPrRqY3srb5EBpmjAqOlTQzd0IBH6PRPcDfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXeYC9JTkiolTD7g6sIM655QVr7xLCEz17lZuBRZTaaSNrfRk1WjMCJ46rd/gOB/VjDjEdxaf+eMilc7XuhNz33rIK8xlbd6O8dIqKd2brBo2/bIARfg7c/r/njFbGoH3vZRBbFXI7E5WCJwCuu4dkLiIKMhkVp818t0Cjm0ZB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VdY5z8Yo; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VdY5z8Yo"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b940d3d7so162255a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 08:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696483; cv=none;
        d=google.com; s=arc-20260327;
        b=NtUrjHTr/wf21peOkqVvjmbKcgY/GBULs5lQpthaEYy2u2n03Uk8yR0tY+vOylP4XL
         mcvbfNehLFAd5GS0ZLhQVduMEhozGTkPm9/35rPb7UBxNa5lWLxEsPPMWh1KkmiX7J5B
         sbZlzawTcauAiRkhY75TdZOgG8uppZfXYjbpfodMSkymW3xqVpLSuLlmDRvrWkRp/OSK
         kcAiffbnABd+SF3h3LwGx9XzVT/kc0bnkjNtUBtvfv3YI2Ko8fZn5VkjGi0lb86WxJAQ
         7magEuPl4J9CqUdEYqTMJCfG3TR38+vi39uf3T/6g5QluuiN/yVqe5TxRo+9Bmfw1d9F
         T2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        fh=wCUf+eWIH3+/lnGTtfFXNrszEUX/PfgFllAP5NHagjg=;
        b=DcTHNtxtBmCmQYJ08DhO5xH/CwjD1JwjDlVcGabkq6RQGWiBlkRmf0rSDeV6g94HRT
         cCqkqlTspCYQCc1aFT2Nl2xOYW1Tk8gfidoURppu04ydEOvn94jWF9fsH5dj8U+BNWYQ
         pT4hzMOsHkvk1GR1pj34BxF53HDICLwlUq1o3+u9osS2G2VWJjhSQVptZAYGulcn/gxs
         YVCwDP3llYkEDiecxLYxm3hORAt0rBJX7YCT9LLenDVSs/duAmx5HzpidcnmQWqA2Y60
         LZNUv98saHwYQ56WFkgpNm3cC4KxUBMCZ4yQIHU9Mm79Iougn7R8Vo7C/xnEkoCBRFHJ
         HRPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790696483; x=1791301283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=VdY5z8YoInDCnVPmPUm5T8INxeOb6a4PvVutNsPnGQMjPCHakCxQ7YRxDTJiehtUM2
         nSN/kYHZA3i5bIxkbPnO9xP4sdyyoMERSXUeQTn+/fW7jwDDC/n6ma9RIyHsAbhpJkpE
         Migw9a1iex6kLad5GdRNo2cpwj9g9EoeWdXQ7qv9gP4J07Tfb3hFB/xBwZD4Bykok7ky
         Vb4fzSZm4jEQuF83TmfGMBsOgeZ7wV+J9INpJeVL6R+lzdOJ8tbUynrrK+jWj+ZOorrL
         x03MuKlVvaRdTxLwhGuYpgaKsiQ2IlPvoM5B3FWeKYUYj+uTNOpPS6mBvowOQwbGIEQA
         4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696483; x=1791301283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=CG6OiG3aRN2+fh8T59WDyd5ilSUbcCE4vo0Rc/WK2GXewunbqyxhPDq/k51jRHY2ZK
         vac7L9mMlaAeo85s3wz7wos2qbLFTf3dvvI7zQy9RAzrtQe4uQOc4/XSgD7LovwDDWek
         Az3XRLE5lKi2jUtpZAogzcfmzmSwETl+oSItaP3JFPys4iekHoKesfsPdQ8retJfMaWS
         MOBVDUKVnr1RqnFQk/V8xcxrzVTvTLBaaTfrC10ry5WTRHdMBaWKghkb6trMGofURF3v
         VLnfFvlDiD5slWx0gTywZDDb8CvHp5d3S+igChixgLHqTf1anxUrqyDZ4/97ztqsEzzr
         ACvw==
X-Forwarded-Encrypted: i=1; AKwUvBxr+t5pOwswTdLwPkm4/3bXh7UMqKCb3236lh5JUTkfjHEwXYtuWtA3RHqFPl7V+rFdOEM80bA73ZSgMaAk0NyB6JItg4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDf4tzucbPjRpkY42czIEkbVfoR5G3OUlM6Vb43CCoZg0o97Xv
	UBn5o51PjUPV6qrp0cQSRlc13g6H+JMiSrsn+nsi6ZT3oX2o5Pknp4qthOk9LmjlUipQYS24UWG
	qnAQhal6L11sbUA4UU1npjjNaJ8y9Rnba0b6xTWBeL3rBAzHUOAaeEQ==
X-Gm-Gg: AYBFou1VYmyO2B6JkNV5AegUA+x9rB2EL7u8qjhp77WWneEPC+r8X3Zs923llMFcFLd
	jivYxVFTe7KrURk7hiVhanflROZJTsC/q79kuD/fyB2wgtC4DombFRaBPY+pwFzepvrKaakvLLt
	Nb4vhXo/kCdwEeLphWq3jimeAMFEzLSSN8AvVZ++MtRxLhXs6P/c39Ro5RrV9zHTy98/UaxcpOf
	r6GyDSn0oMlEGSDFdGAwzHGAgtKQ6Q8O6rfcqAmvkNd6uQLC67fryhbHcWLnkL3emuwLcxC/pDc
	ZpG55jnMPR6A9m8Ns+gbAZg/kegU68CiKcAFcZ1WN1FsMRvcm/mSagHyTpDxvVD6KvZHDJkOCYB
	xofAYTI1l6tI=
X-Received: by 2002:a17:90a:ec87:b0:3a4:a2f9:f2f9 with SMTP id
 98e67ed59e1d1-3a4a2f9f6b7mr1995395a91.52.1790696482601; Tue, 29 Sep 2026
 08:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
 <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com> <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
In-Reply-To: <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 11:41:10 -0400
X-Gm-Features: AclHuK-k4dcV8AsNHD2Yr0ha3qdtOhv_YrLUXKayEeb-M3C-kGGNkoHEhnTeD88
Message-ID: <CAHC9VhRdn-jrNJY1K=1RsZQiO80QKR3nD+DHyUM5n_a3TrxLhA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:21=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Mon, Sep 28, 2026 at 3:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > >
> > > There is another question here. These new hooks do not have any in-tr=
ee
> > > user at the moment. This appears to violate the "New LSM Hooks" polic=
y
> > > in [2]. Could you please give more specific guidance on this?
> >
> > There are LSMs which implement mount level access controls, you've
> > been updating those in your patchset :)  I believe that some of those
> > LSMs do have some (full? needs verification) coverage on the new mount
> > API.  I would expect that a patchset that adds, or modifies the
> > existing, mount hooks would also update those LSMs accordingly.  From
> > what I've seen, you've done a good job updating the individual LSMs
> > thus far, but if you have any questions or are unsure of what to do
> > for any one LSM, please ask and I'm sure the associated devs will be
> > happy to help.
>
> I don't think the scope here, adding hooks for fsopen, fsconfig, fsmount,
> fspick, open_tree, open_tree_attr and mount_setattr and using them
> properly in all LSMs, is a reasonable ask for a single patchset. Given
> how much time this simple refactoring patchset has taken, I don't foresee
> this work landing in any reasonable timeframe.
>
> Please consider reviewing this set and landing it before asking for more
> work.

[NOTE: dropped herton@canonical due to bounces]

I suspect there is a misunderstanding regarding the new mount API and
the LSM hooks.  I believe that we have all of the necessary LSM hooks
already in place for the new mount API, but since I haven't looked at
that in several years, verifying this would be good.  Beyond ensuring
the hooks are still complete, I was suggesting that if you are going
to create per-operation LSM hooks for the legacy mount API, it would
be good if we had similar (same?) LSM hooks for the new mount API.
Alternatively, if it doesn't make sense to have per-operation hooks
with the new API, it would be good to document that in your patchset's
commit descriptions.  Either way, I think your patchset needs to
address the new mount API in some way.  I don't want to speak for
Christian, but I believe these comments are in keeping with his
previous comments in this thread.

With all that said, you did identify a potential issue with resolving
dev_path multiple times in both AppArmor and TOMOYO.  That does look
like something that we should fix regardless (I see Tetsuo has already
ACK'd your patch, but we are waiting on the AppArmor folks).  However,
what that fix will look like will likely be determined by what you
want to do with respect to both the legacy and new mount APIs.

--=20
paul-moore.com
