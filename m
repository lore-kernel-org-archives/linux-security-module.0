Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C43955F1
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211679; cv=pass; b=W+nYWBdYqtZq+I8glL479I2VgFtPG+jGJ2xoOZXe/C/DtBh6bHvdHfIoNf5+L2/07MXbzsJFnQWBbRoa79lS1EfW05EowI0MiJmXQJHEorJKuH2mmWyyrquUlWN/saQFUlkNnxornwYqJHHL39BTrMwzHgYZINyXTcG5GXam5MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211679; c=relaxed/simple;
	bh=yTHTdSbwM0jIYQIQxOZKHrg6+D5erA2cHY/eW+jop0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYux9Mwsz//V/m3dMg1sJzr/1WuVbbuUcfRYpOHUSyQ5eCoa6gbftZVE/bNQAVlDZy1QC6sI/rUQWkxo8n9oAK/1AZEMWaYgSuUAy4Yj9BeKdmckySTzeSVdXxiNke25NXwtVj2WWOmbujG+vznwGGmKayMXZEI2QTJiTauXULs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HBaQKPo6; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HBaQKPo6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d91518a63fso1121965ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211677; cv=none;
        d=google.com; s=arc-20260327;
        b=j/6g/yzNp+m8i70GfFQtOzT2XTHngqQz7GNEAe2Q2gpzUIMVd1YM3yUAJj5GklGnXG
         cO8ASDligqElr2N3gqa4MS635qhoLENBTdEh9Bxga2mZnIdZilhzZ7+CvKDz9GtXnHV2
         T9hhhfhMQXz0GajdeSGJyDWvm9gO0/M8PDS27J73HkKHsOiwuWmF6ciqTyPXvCK/5/rL
         Zzew8ob7chWgvwMqOQ+AJle2WZj8U+SKRLB8LpkDn9vtPsaD+OQGvpaXirFZjU3Vamec
         Z7hkOM4hS6RnfoohEc5cykj6XCveLjpUBUU2HnIqbdgJWdxooO9LjfIefcIVBhiodCur
         Z89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uib+h/AbmDRvGw6OaHSNOXJWYyNU1BcABtaXv7oLMeo=;
        fh=abZXrZHFtrq0xipQ8HJBnbgsIfvTjyOo0lKzRyDCwys=;
        b=ZFHWiqWq46tpudRu3lejJV45q8OWC//37niiv+O82ll3lRoajdwmGrpQqAvjNhL8z0
         9SQgCpTRJYCqtaLfWXH3Ye7ZQBIGyx1Y/1P5aoHjYXzPmwJQ7XPpVB1rkYPg7cPP1KZ+
         aUTIdKOjDEBTmT8HdIZgBLY94A4+4/la+lZDj9nypIgaK49Rj9YBTE8TXiZG2xs4f2hf
         U876u04JOuz8dOkXAtQuvMw2LSwggv7TQmJcjmFXHD3AwHW/3RpAiBEv3FY7CRHEs1C2
         CMfqcZ3FRgZNzaPthFeK3tYT2r250Hc1m44DCBSKntPgueeRE507TIE1uvyzkWVV2OzY
         3H9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211677; x=1788816477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uib+h/AbmDRvGw6OaHSNOXJWYyNU1BcABtaXv7oLMeo=;
        b=HBaQKPo6M2gwHj8JVkoMemqRa0PxTKFAJVv8cjeASuY/i01OVq1sJx2V9swWwRs9Pz
         BYOrJfktdX/fngnKO0ncxB89wKFNLBo7jn4O3WDSbz2nk523m29X3+zpfZkTz22pIkMY
         QSBkRNCP01QufSDELhOtENMTU5aQp5q0GcSu1I9VbzzddeUcUY2nHbqNt5QIKK98crQl
         aezHfTPSTIUswAbjFtVUkgsUTX53bCytOjCUAojshuOshoEJ4S/dKXIdmomLiXdDwtmd
         pKQDwCnBr3M3NWgiMP0RG8ksheXI4LsRa4WNDMkwuwL8lEyoR0BEBC0gkd8y/05Nlo0V
         nnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211677; x=1788816477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uib+h/AbmDRvGw6OaHSNOXJWYyNU1BcABtaXv7oLMeo=;
        b=AdfPNMLdfs2emh9zctX098kvKXTeUimvi5K4mqMF0/drJeIW2u6tzYOdO5vJ3Ev3fE
         BoP2rSgjAuxwJ1aINLLLXG/469s8c72wrlyIRsDXpUMA3IcwKlLVHZsaBBNbv4uAuQ2d
         iEIyp2np3ng79bgJ1tTcQtaX+SZHz+okZKNwKQZ5DAOkpwTVBCF58xAyUnEarTXVxk8v
         Yp6plaX0/PTTa8DVJiK0EH0QKT+1M+JWh/yFgSbCq4ehpLb5KFTQ/e7blhxAhin9GxvQ
         MMGGmeZpLD0fbh3kP8sVbQrHbHNiz6poIajTsWaO8ptR6deNs0TJrkTu2ahfNp/oMIbG
         B5dA==
X-Gm-Message-State: AFuF++mIvwtP16jQcfwC1cdmzKwhpTMkYavzePlBJXR7O77UJrBEDE/Q
	KmHvd7rzV3nWOUcu5lcRNyvlpg4y4zUU5EoYhnwIqxq68KZ0ujx15vsl1z/pLw2hA/h9GtF7Ibg
	gGd4+L7t2SiRBwzX5vVgdauc7tQMmkaBTY1oZAw2Dmde4I93zNFmWrA==
X-Gm-Gg: AYBFou0T1tUgbXjXPgS9KsyfnarNmgIGmlu+4sul/TJQO0tCE93dZFBEZJEk5i/vkSl
	jb+n72TKAdM1iAoEgYmdyiDhnbiNTNYI9f8HvPxgUuYtBtpGJCkWsayGLc/gXNiJfqcneS4k6Lx
	hGH1nOvE9x5uxXNLnNwtSQOe1gB1t3M7qcv5zNjEpnfAPFSIxjoKZWP4F4GTCxUWCk9W6/reNjF
	MnebRap4ERHqVSWRP6adQyv+Dipp1NhxCp7vWUvtLLaQSPypB01ejbPVZlKHUVqG41D1DPj+EfL
	oyvS42KZikEPNZszH9Dtmhp2Txg3/39uWhgwAZ58zV5W
X-Received: by 2002:a17:902:d988:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2d74e0cb133mr525716965ad.11.1788211676733; Mon, 31 Aug 2026
 14:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813180816.223079-2-paul@paul-moore.com> <CAHC9VhRRgLifObY4Adgxe4FBmXn-wbxYmx6unMXtmdTtbWYMog@mail.gmail.com>
In-Reply-To: <CAHC9VhRRgLifObY4Adgxe4FBmXn-wbxYmx6unMXtmdTtbWYMog@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:27:44 -0400
X-Gm-Features: AcwNN1WjDfQrxM0apeV_uScdXizUUKNnmMNtHp9fUevDxIZbWPUqcvPQOmdTwkY
Message-ID: <CAHC9VhTGjva77Tf+7obKPkeUvb13++9gDyzbZ=PSjNcVeqq3oA@mail.gmail.com>
Subject: Re: [PATCH] lsm: update the BUILD_BUG_ON() in audit_log_lsm_data()
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Aug 13, 2026 at 2:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On 32-bit systems the newly added namespace fields in the
> > common_audit_data struct exceed the BUILD_BUG_ON(sizeof(void *) * 2)
> > size check in audit_log_lsm_data().  Convert the size check to two
> > u64 types to both fit the new fields and move to a size that is not
> > architecture dependent.
> >
> > Fixes: bb20ca26f960 ("lsm: add LSM_AUDIT_DATA_NS for namespace audit re=
cords")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202608131232.Owej9tlx-lkp=
@intel.com/
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/lsm_audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'm applying this to lsm/dev-staging to fix the kernel test robot
> build failure, but as this is just the dev-staging branch, please feel
> free to comment on how this is a stupid patch, ACK, review, etc. as
> you see fit.

This is now in lsm/dev.

--=20
paul-moore.com
