Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730D380FEE
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569240; cv=pass; b=ERCZ/CnYtzNhIo/Y1WdV9lvM4Kk+bg1a1O5Snvo38A3V6sN0dGyIsPQEzugGGZiFMM/zq70wqzSsQ7MW4h5lkfdVS5N5ct9dFTldoPEQ+KqQBAkHO4KiLqT4JIKMd+Pfw6z9Nze7hFFTPj6cHdhNd4mgCb9CcGX7zRZoPgnI+NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569240; c=relaxed/simple;
	bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gds+SY4TP1rWWy5zqxnenSxZOrANUgzsycO+grvenlymRomelLU3j12mlvLY2kOWN1dV+YDKBfIcMYZ77G/kssiSjwe+IxwX8VJi82uKd44b8uzB9Z/7l1/+gBlmwbl6QrvPgKVfQFBBoBPkkHSGldlXp+Aa5O6SZvDIeTV0wKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enlP9BVP; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enlP9BVP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d6ff3aca06so115025ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 07:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789569238; cv=none;
        d=google.com; s=arc-20260327;
        b=L6KxRgaklc+WECZrezWxZFwduOX1txI8sjdqzlgYrCBfhfKEXqcn6VduRx81HUWJ0q
         DQkNyxrBJBTh3iFEI/IGFghWvLWcYCLRK44NyHkh2caJAoulU9TWw8TOp3GfJVf9bOhU
         r3rsa1TxtfQjNfRl+WwIldMKKivpMUBS2HOulofqQ7Hevf0SWQ89/RzyNgnlYWQjrREl
         WmvSw2AcQMl0vFzDl3xyNgaIPj3LFxaSdDojdX3dI/YLy89ZUM+i1VZkn+omLSpBnRus
         PuyynMn6J0X092F10avxP9OBhdU1heQtAZpUUzOMZ6auwiDhBUmT3TqAoha7y3qO5XMf
         yc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        fh=6qT14QknTIckuCB5VfI0oquq+nUqHHHrsXrBnzhuWm8=;
        b=sbEJoRwYoo49kPn/dGYnNCbNnSGK4rhVlQTFUtwvRuYQ+463gxm6B11fT/GP69iWuz
         GR0q2qHKbrBQRRC6FbvkQFqikCdQYO8LnkQ6bXhrFMwbdMFzMJtsbo7UNUFyjQ3HddvM
         LkTRhueLiV3ANHWWRaGBwooyqF2KvnA2Q2u30JIOnIMTvJAq+xstBYuUN57JxJFy0c9O
         bQKNQvvhBLMNt1wXptTKCF4RIs93xTxexbYun4WeDdr0ygSb68qEJ3AJHgJsaoQZRTW0
         xL1ol+OF00wzeF+AVjc15OSBdwZDa2imxfa8sCONJRj70/skD5R5rjjn/HkrNQch7x9v
         mI9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789569238; x=1790174038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=enlP9BVPCseMCloxPgKpmFrxpdvmDWfyw0wlrGMj5nishBaaJ++qgTLDrXA9Ls06di
         gRT8tck0R+uTqB/pfBhSFKpHY9Kkqo8WK22itILYNg2HPfwiLEh3J4cKiCmw1kVSNAkr
         aF+NAV8RWhfzoPcKayF6UJToDx4ykr10POgjLyAkuremzJuaGQRAr3/P5XbpraMeBGQC
         po1cw+Bi09jpVJhjja6omm4xsJ86Jo7TyBvb/aqYzXz4ld0q13dEJKANC9CxeaZdFFYi
         Hi1I8tlvYVmwYKDvQYayGmadLQDwtrlMNckw0PFBlVKM5R3qPNlBHXSMJ8iIT4gakwce
         uYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569238; x=1790174038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=pJgJLOZmGdNWr91zkwRd4eMR7Eu2sfytl3MAag4W8/aZV6xra5P0K3vRg0X7SeJCB9
         DHpKCw81p+B+8JLjiRzMORpg0K6Eao6zp5jYpdALI5EYBMwMeobNPWaraRCTHiMykk5T
         oGW6a9h/noEwTBwo81pX5+cTQhk4gxt1dU0w4PhNLU6rzZHzs1jG1D9j93Fd0ikVoSt6
         nds7BSGbxirR6uplphRySgUisvVzVZTPsjJWaw9qHOlCmICs3QXdVRCXXxpMeYTNwXqy
         OfVtn1ppx6lMtCQHaQgDInKE4Gg9I2cpiM6+aGmCTwOSDMNSJOjlSl5R0H2oIMqMtAO3
         aXpw==
X-Forwarded-Encrypted: i=1; AKwUvByXWFn82srqjCVcjAojvjop70ODHEeSZPD5pyAt/rxVHRDCcWAAUURDVLWGH0rG95ajZO0efv1YrGZlFaZD7DCrlMm6Syo=@vger.kernel.org
X-Gm-Message-State: AFuF++m9Wn/VH4jU6knmhaTS5HDAjkQRx2SDzWBVh3+9vcXdMprmN8PO
	AgFrCsvW8hqEwQdQsSS6K6IznYmWt5zNhEGQIKZhKd9BKvoA82KHZeqg0UkJ2TQsVWZkF/GlOqN
	kRd9BWselGg77NzHh0eS6+pViOWIykxLgdXbaxwpU
X-Gm-Gg: AYBFou1y1IsTtZZb/8qeyIEoo1XCmEL2z5UOTiRTu4yKld5FCB8/rq0GyXcFIqzKMz6
	TT1qdo7p2slpPcjSvSmD0MU5wyJuJjV+y9dDLKU6oBOBuwtUTa2htid4kPbgk/+0CDPR5uiNmx1
	pI6pwGRNMsMvxBZSGlEDxYeBMSjXVFZ5ESEQodH1l2wDfhlALNA6rvgwTbFtlpdn+Xr33EaL7xx
	rR8nx8RP7ECqivfI0YD82knd22gGkS0KkBcKiyRV17G91aqCEIrnaHOHxYSYAFhNFMkAGzyEnX1
	jG6tct6tV/9A2SHidHgMdFHrpYhwECEyndxlVsT1iHSv21gyt/zezuBl9y+fub0k+PnycK+4LCQ
	VR6vr8Yjw/bINdqc0r7civMq2NJ/N+yPpFDefH1RLuA==
X-Received: by 2002:a17:903:1b70:b0:2d7:2a35:d14 with SMTP id
 d9443c01a7336-2dd8e92caefmr4932795ad.11.1789569237830; Wed, 16 Sep 2026
 07:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Sep 2026 16:33:20 +0200
X-Gm-Features: AcwNN1VHcCpN0atD-cxO0BibJJcgM5o-LVFXYygCh_MGPfeRHWgz6O_0BmL4XXc
Message-ID: <CAG48ez3DRgU7eQtF71EEQw72+xV5kWv0nQn==9uVd=YPyGhJUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?

(Same for me, I don't see that mail from Christian on this thread.)
