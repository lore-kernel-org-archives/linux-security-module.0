Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370601;
	b=qiqZRv+s3M3psT9f+T7zsuuJZ7vCuhb2+FVlc7rRSflrGKuKa/CX77xUJjKR9Qc+w2QD
	 F14vrVgmKD9p/+9vlNn5zdArBlca7miDMylRJIL+H68XWPsBgYeIpaWBywkFUlYMNg/iz
	 OVIcL6ktLNfv1Gw7yOCSr+2Q8Ob0blqBN7wNyLXbLDqRzJ852743UmrXG4rXQZc/BdLbe
	 q2S+B1UZJVZSV0+3whRN0ACA3vflvJVKOGcU48gRJPEg6X4ncG1WUWRxs0PpGU65ATOJ2
	 ZVKWStYP1SPTZa+fIx48lYorW0MEggTSEmIlfvtmfn5oDecREVomLMlz8gVG1zjYnJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=mYpdnsyPHrbQlI9gQjpkgVMu6bBztlcU0SAjmRmLasU=;
	b=rFvWa65Z0L6qNVMJE2qwhWNuLCJ1k9Jgbqg8uzkI8ROZlrYOedLt4BqYeZk4UQ2QLdY8
	 UCaVbfqcWqXKX+/3OrBZT7LH52jQ/lvrD8b1xDqJXFQo+5q28rwJ/+nhpdVM+dyqKF+HZ
	 MAUx4EgwQOvz9uEBqgMmY3mh2+YhfI3F8Q7oWfThbC1DgcUd4Ec8X8koWjfl/4xTep5/f
	 xyeft3v+r2qLwZtxyfdM9RHQyQdFgX19Cr891Wg9z0LHipZWbaWLCOgJCdY1ZoUkU+p9E
	 bwv6H/rTzFpBPLDz2qyuayGEkfvB/lHWT3L0CoIDPIn6rdPMVvC92Q6oXQ7ojvT1eeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngWCYSkU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D9606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 14:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B8D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngWCYSkU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so4532215e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370600; x=1793975400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYpdnsyPHrbQlI9gQjpkgVMu6bBztlcU0SAjmRmLasU=;
        b=ngWCYSkU74Iafv0MedQwAlHJOlHRepRvB5FZ5oV9Srvo99S5+oc9wGmemWsPjzOQ3y
         rEn9cnUi47ubbRcaoqzhY/Zx+b1+cNz0eojrHKKNT4KPJO3C1skgVKRCUduhBlf0X8qr
         feFF58sjtY2T/S0ORrisK7wNY+iY6Vqa5AbymaqlfyY4AnZqFf2IrKgJzZyRHJ0iX4Ck
         inSBlTmnLylV/C/X0so1CDGRKzsUWxSVgQshjuby643z4AUhP6nLhyXUZW5ysZ6zom0Q
         wBW7P5kpWuaRP8vIA1tAzN0oHbowomyx0ilvqo7l47xqowRHmN4OQkZkMU3SWwNkULX0
         4K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370600; x=1793975400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mYpdnsyPHrbQlI9gQjpkgVMu6bBztlcU0SAjmRmLasU=;
        b=nrXSB5h4dllC/kPbfblXkoktDmthSio0Cwyh92ksjzS6pqy9mQcVVnRR0Q9sgwMYGe
         vO+pFhoGT1SiOVZb9OlVyEVI7P0KdZTClMe29AEQH+IYTxCtSPvWH87FnCZTQWpvpUJC
         PYB2ur/0YFpK8Yw2ldbQZ3fedbqLnFJOYLJ0h68xs3f+qut7h0UX9nQjolLN3Bpgwb5b
         wWp+kXwoHhkdFJSNPYGNXfVw+5dh1rHOFs5IVtPPwnZTLWPCgFYPmCytBAHrUEkvNcw/
         thBFY+FciQcdo5DIg5NEAOVJIzihHhSgUJbxb4wK3F2vDPIbykui+VT59tD19oNhD3Ua
         R2Rw==
X-Gm-Message-State: AFq9FYKs426Q04bixlsJw4j/cSGNiObkAyv0LpjITTNqQlE0C5+ZFq3X
	iMFs9rmq/xYjcDUct+CgvFX9wluIJEj/izC1/J0ORm2rQBDqAyhFJmjH
X-Gm-Gg: AYBFou2keuNotrbviMazvQGBBuUbbk/cvfYxu65YWbQJ0jsBShC6VvopaifYQJfftA3
	l+8rI7i/5euEF9D9No4WZMZg/v4g01Gsesl3lH/feS9uk7Ok1aUk/4qn7d+inWLhkHZDh7Og5gW
	mgsVndjOWXr2psqiIT/ryF1Fhicqwadfwb5ub6YoTS5UzsyPXW6d7YBERPKjB95fTo7hulC+/re
	cJBeWRyaI8Twa8rFjvRkUD1z3OGDc8Ten1/TYVqrInf8f1l9o7UZIWvQLdjgzHSmlqwDAlKzHIu
	5R1uKtmi29lbynw0kIZOK6sM814jd3Na+uVrL3hDgMaoqNqBj0kDx9e571mhMBpH5g+D+Z2wG5G
	968Wh4ycnvgt63NYD2ewcIus6i0WkXLym2tjNUMmIh5EOGMPIZOaYwNE+fG08Pv3M7OfgwUFLSe
	l5uadvghRU7eyhAtt4CZte+NKue1+S6zdLd8xcwgSbZkgqhj4OR31jeXrjcsNWxM41ZSjBU4fne
	Mo7zq/wzYyqnBeQp/Qk6Kna4lvOdAb2eHdebpr+jO2vvliPtRPMHKLS22Wg/dKCqS/sokvAfbEj
	W1QN+Sw+UYosXLkVa707u/r+cmvAmqpo8qPvAhn8w6XfQtTYPeTdcw==
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr55773015e9.27.1793370599597;
        Fri, 30 Oct 2026 07:29:59 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm67672815e9.6.2026.10.30.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:29:59 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:29:56 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Dwi Siswanto <me@dw1.io>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH 0/3] landlock: Fix REFER in layered domains
Message-ID: <20261030.060f232cddbd@gnoack.org>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
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
In-Reply-To: <20261030102411.12985-1-gnoack3000@gmail.com>

On Fri, Oct 30, 2026 at 11:24:07AM +0100, Günther Noack wrote:
> This patchset
> =============
> 
> This patchset fixes the issue in three commits:
> 
> 1) The fix, which should be backportable to older kernels
>    and which is CC'd to stable@.

To be more precise, the fix needs to go in 7.2, 6.18 and 6.12.
Other stable releases predate 6.7 where the bug was introduced.

It does unfortunately not apply cleanly on the stable kernels 7.2,
6.18 and 6.12, but I have backported versions.

(Differences: In the stable versions, the affected helper function was
still in ruleset.h instead of domain.h.  In 6.12, the constant name
did not have a _ prefix yet.  In 6.12 in the tests, the
drop_access_rights() helper didn't exist.)


> 2) Regression selftests.
> 3) A more elegant fix for newer kernels,
>    which is intentionally *not* CC'd to stable@,
>    because it would break on older kernels.
> 
>    In newer kernels, we already add the "REFER" access right to the
>    handled access rights when we merge the ruleset into the new
>    domain, so there is no additional calculation to do for it.
> 
> 
> Please let me know what you think!

P.S. Mickaël: Specifically, I'd like to know whether you think this
warrants an erratum.  If yes, here is a tentative wording:


   Erratum 5: Correct REFER semantics when layering Landlock policies
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   This fix addresses an issue where, when multiple Landlock ruleset
   are layered, Landlock would restrict LANDLOCK_ACCESS_FS_REFER
   operations which would have been allowed by the same rulesets
   individually.

   This change ensures that a LANDLOCK_ACCESS_FS_REFER operation is
   allowed in a layered domain if all of the enforced rulesets allow
   it individually as well.

   Impact:

   This occurs in situations where one of the layers does not handle
   any filesystem access rights, but one of the other layers does.  In
   that case, the non-filesystem layer is interpreted to deny the
   LANDLOCK_ACCESS_FS_REFER right.


–Günther
