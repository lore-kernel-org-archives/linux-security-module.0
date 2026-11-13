Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600997;
	b=Ffz5PU4/rXLVRmH3NfeJz0SADel5lWtDZOl48JmxvSbp7+KRvXmyh4miT0XtoKztnCU8
	 J4xksNMbyz2w/bhjx6NvWiNHGqNrXHsIcdjGo8qI+KMI7VqqD34ZzDAzc1OvrJKcmNdpP
	 MFfSZLE5TUnYadFoWyhFOxvUc8Hv5dgQCY9FtKX9wxxAqptZFqtxLnssqVHl8TSDJA7bs
	 +JTVvrs2cG7n7Sv+DGV8S2qAb6DT36D7A1TKQcr0/eV3CCXARbyI/fI1nBAR0Fupi21z/
	 1PMXJif7oLoCKrKsGp+tM214GiMS40sMMERK1TGmfa94GQxhlqOb8jl6xXKnzaOFK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
	b=oNciHlQohrXntKZ7thn2sHSHDW22y5qLF6X6CXO7Mlt4kKZ0jAcBsM5YzkL8CfSTTbJP
	 lLDvBxcDAtoOlwUu2s+7U43xs7GJtVs319dTI5ALxvzDa4MKu/PfkoRvu+j9iT6fFiI+5
	 OOY03Ks0ozPuOMteO5DxR/oJw1rtcfXGNOBBGHQVoOLBGyv22iV0wQVEtZ6Ve8ByPMTBH
	 dUUnVhFw18mFMP2BWYEl5mQjPVwSvpsvsQJOzai5Uow6AEYOTi0i5WPunysOLmOC7sQdJ
	 XGoI8FrNMifjaoi+FG3iezSVtT7KG8/0MTFD7XFthX5ZPPKGq2J9lVSZwLX4/up0vjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggbFz86P;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F8606A88C
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464F8606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggbFz86P
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so21254415e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794600996; x=1795205796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
        b=ggbFz86PZ19pd6a8yEtWjlR23GMGBo70CPaecmEpktaYZ7ejxop4ikBV5MVOgkRHMB
         VVB0Bin4edGKZ5WBgJloEF18Eft0y2T1hL9bil0mEcjQCetqmBvXjwneWo0rpK7/ly/w
         EO9QR/VTRQp9ZvlvfZUL/oxz4QPXafAQsvJnj7ahdmhRN9dwG7iX9rfW3dF6DwLP/wF2
         u7UNZkhV77CvP7IPQZ3EKgqzJTpwhWrXNjODTjkVY4sw8kDX5rFVYaemcHt082sC7zE5
         QNangEb7P+jmxxIwub/uQIm/2urZf+bEeeQbAwecFBVvsrOi1Sl5P5/+BZSPBzVnzh06
         r9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600996; x=1795205796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
        b=c7uLYGzHNDKZAOQ0XC0OjxNBQsC4rPjAgUK6hYVmCYYrpk+6+MNb1uQztpfm/MIfBe
         Eyk06vqUadZJMTj5vkQLxkd5hl89eMcBhZFANGwSAsTi5KJSD/wHFhiawUnVD0XTxvdg
         ta6DQM1zhRyMSfAb93vHntiQ1EmKEtWeSo495HIVjY6VjGXkBOr90+H0VSYcsOamyDcY
         8QYfwJgokd3bDpt0H8jES+sNVOBKCOAjdFESTF7K4HhtE7kZ69JB26v55+AzgDBP/nMi
         L6R8vqJO1wMGG3ht2ZzJcjLnzc4XntnSXqd2n7IBlv/FmDYacERn6OxYeJ4yjMzPHKmW
         /D4A==
X-Forwarded-Encrypted: i=1; AL+hErEhbOZct+RWLQRoNHsUnudIMVI9UGiOLJeJExU5Dji/a4F9WHbZ0rI8QZ9X6C1unU3St/KOCmhgu8vi0h5GH8oQ7lpXFrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n3+w3sXkBQKnwmvA6hUZLG2+DAN3L8IRXhdr6dAVr6cVVU5l7
	5M4gkpzen6i5OcXfy7kVXGp9qLD2Hpzf5ma1EyGR5Slu2/CwMm3VBAhp
X-Gm-Gg: AYBFou1ejnlnrY8N1PR4RXERJdjG9BLbi/g46eeOAp9yPUxYXU1UOBPREKGzDxfHv07
	XbfOi7zanq8cFtLMgGQ27Ppt6+nmsWdqbfGnbMjJHcgj/MZC35gZXFaRLfzI0QKKTCxTf8cVCUH
	T4QZ8wl33Wln9xSQgYJYvQ1ua0MuXCoIjNtFSYxsn7flwtV7mI4CzsRP52QHPIIS188O1tp9oGu
	QaCmUlR8eq0phFLdr3oLYABRg40h9GSHszo6pkEnby9PJqQRz7eJg/3GiMc40y4DJMcE57aYknl
	PbadN8utmXjUVUcPJ3wYXC4gZZB6NFyNE89o849n30/sHOu1GZIbdNgdpHX2oDfzn3zh9Ptem4W
	hjZBeDnUe+18WujSFXIRJoA3M7sfx/UoR+wZaLiqqDrUrBy7om8Fn0Af61WA9ULovBEOVE18yJw
	QCeSH7MUNoW0nindoRRzgaNOY5cFrGRjdftZDohecqrBg0zgRGjxhn2b3M2/yijzqe7xxcaNmn+
	a63TjKKLH3WxP3NywDD0A7mynUsGcWn8DHNuCDl8y/63kqfIFg/0NdnbEu+gO+pOkTTsEnmo+5U
	bQ7wCX8KxZhSRZcZqEE/UZnoGml9oZ65Ao2MdwQnLs882JNPCgWwxA==
X-Received: by 2002:a05:600c:1f96:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4bb55a4ea81mr74860855e9.14.1794600995421;
        Fri, 13 Nov 2026 12:16:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e293540sm178215465e9.8.2026.11.13.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:16:35 -0800 (PST)
Date: Fri, 13 Nov 2026 21:16:33 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] landlock: Fix REFER in layered domains
Message-ID: <20261113.3fa14baa784d@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261113.eiChee8pohch@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113.eiChee8pohch@digikod.net>

On Fri, Nov 13, 2026 at 12:24:52AM +0100, Mickaël Salaün wrote:
> On Sun, Nov 08, 2026 at 09:23:47PM +0100, Günther Noack wrote:
> > This patchset
> > =============
> > 
> > This patchset fixes the issue in three commits:
> 
> Four patches now.

Five patches now; updated :)

–Günther
