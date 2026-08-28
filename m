Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD7360EE5
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931787; cv=none; b=HA9p90M5vRS0mfjKeRgKnppb/YemxoHlPUCvc9AZJV0jBNqCXYMBh1dCh2oIQ6PY6lIUhMaGgA7oIVe7L31AhDnVrkc1dF/4mDGja1rJx3jzC3VmnSJMgIW1yXh+G9qmT9l6xqtPN4om+sIvAiGrj9kQRxhu7i6YsuWa95f36zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931787; c=relaxed/simple;
	bh=sLVczotwTOFbUu/Jo1ae/boEThFGX00e6B8LS8LSD6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko+y3I59Npw0qcFPkPHeRODLZOf+4nTXgKkxQ/CGeKnzfQZKF9oeN7WK4jSTgDLmJ8c7aBMNB/RrdtY1ATYM0ihzYHbzBqnxOaOlM5LGyYk0kmQQP+CeIpc3+LbhVvzkfaBDVNbFjM1GiqFxOqFtYFb2d0aDUfAR6nrzufreJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3F18UVg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3F18UVg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso11711585e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931784; x=1788536584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqC35LNHeGLfQ6MG3PLDTJt/ova1z9Yr87pzuzwckbc=;
        b=E3F18UVgAgj2gRaG3wLrivRCFvZHR7oPOgNg4sRDXobVb2UCQYYp44eT72u4H+ln8F
         m7A6HU+JyW6mQ48QRJwbJLsJ1oROgSkhZQkrC6WONvnhDwjHb+rWmYaI3JcwwWsAhbsb
         s6xbzHkKMscSUDhKpKN8PukuSU2OBDyGTUs6Q1ifbER3QbkezzD1TUgeK+Ij0H84VNZQ
         u6ea63MQzwE2V2WUynZWLXSrEUsgbsL7O94qfomil4NRL60TasyXOsaX2nCxx/OyWg3a
         VduvtUkpXADCOEp/Cr++EeMpv4PX485wC4sPN/3abcjPdMV+G3dN1eOEhKMikrX/0x0V
         o9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931784; x=1788536584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kqC35LNHeGLfQ6MG3PLDTJt/ova1z9Yr87pzuzwckbc=;
        b=ImkPcUorhN9ZWn4yZYBc8o8G1comEAFa/pmcNVkgCSmoOAc6b2hdu69nHkwTBfL+lF
         8W/WfIav+IJSs5x8rOQzjjtMcDrLBE9M6xdFX1gQ+2c9Bunws5QnxgzVCrR1F+oIKaRw
         6kJdgOwuGw8rd5D3A8EnwlY687YdLJbUv4mTv3P8HAeMiDI9uOKpsIgBPkcJb6h+VFwF
         Imn29XFMbwYa6+cqDi4GFCyEaRhiJwgbRLhrN9G4YqB7hK7r2/FeJt4ibZy04Ytigetv
         ruwzb0O1rz8rMy3cDEKFxxVMWqsAnRv/pOOGHiL4lZxKXB52P6FYF7UtpdhHuLkz3S1V
         sXcg==
X-Forwarded-Encrypted: i=1; AHgh+RpgeV1xs/xG5vhCBuFQ0h+kHVsNB3fNyQbKUjnfvHpEnDL9VfEEIO2KG50RjTeXFA1QZEV4k32+FdwB997EcSKzMz76jpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l+j1/nbJnG48SCW2/Uk5Kdcu4lav1rhIPcVw3/X6yvpqr/03ud
	pQznGdzBjQYZkkS8aFsQKn8jKBdn3iyKw6841pi9bKL+twUO6nmxc6ya
X-Gm-Gg: AR+sD10QHsYtIf9s1xxNLTRNFz+dGEmSoR28R7oxV+RlAKpWTnKuRt84hxUkbo2E5gr
	PtmPSW2csSTXAsyXivfSdKFJHMLFc9bQ6+nZqD/7eTJ8CMlrfvJqRx0Qqzr0MNmx4JHR8s98lth
	/rKDpu5vBvHL9oZidk6+iy9vcWp33unSXsw9R/IBETiLzvWIRPTjZU0ofFriEDXB8FpOtVcysq7
	IpawuNTI6+yqKl+tZ6b5hA4rhWKUuLWf1aiHAVrRjo2kD9X4Ox0o1I5BMVu5nuCftv9a0DWfAt8
	9+1r+us8ZPie3ZvNyIrf+Y9sYFxgZQZBGZleMP1zOULL0vZOWYdPpPhqLYtpGzbIMnItahvAN1A
	PuMqyyXYbv4RYTPl2+Ir9W8WZ1EzbFacGnicdQnb9aq37CHzYGXmGzjV2YaBSNaOoZAZq/hSt4I
	wmxnoSmM3nCz2qPL0o8kHyfSo8bU29NKF6mR5KZoWq6dqLlQzSLgBSziTlwD+ZghseUcHB1BK/y
	D5tYVb2vWI/Dw==
X-Received: by 2002:a05:600c:1908:b0:49b:9113:e03c with SMTP id 5b1f17b1804b1-49b91c26365mr93981855e9.8.1787931784102;
        Fri, 28 Aug 2026 08:43:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca3e642dsm3938915e9.2.2026.08.28.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:43:03 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:43:02 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v1] landlock: Demonstrate best-effort allowed_access
 filtering
Message-ID: <20260828.4da5817dd90b@gnoack.org>
References: <20260513151856.148423-1-mic@digikod.net>
 <20260515.3306db78edb3@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515.3306db78edb3@gnoack.org>

On Fri, May 15, 2026 at 07:53:27PM +0200, Günther Noack wrote:
> On Wed, May 13, 2026 at 05:18:53PM +0200, Mickaël Salaün wrote:
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  Documentation/userspace-api/landlock.rst | 48 +++++++++++++-----------
> >  1 file changed, 27 insertions(+), 21 deletions(-)
> > 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
>
> [...]
> 
> P.S.: Please don't forget to also transfer this change to the
> landlock(7) man page, where we are using the same code example.  I
> believe the overlap is mostly in the code there, and the text is
> slightly different.

Friendly reminder -- could you please also transcribe the newly added
documentation into the Landlock man pages?  I added a tracking issue
at https://github.com/landlock-lsm/linux/issues/66 for the missing man
page updates.  I am happy to do a review.

Thanks,
Günther
