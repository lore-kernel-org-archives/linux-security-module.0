Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3F1DA635
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459799; cv=none; b=fFxsSNFzRAVTE97D8Q597WC5H0ZvdW9I3ftSrzxxma5CXTCB57zQ+G42x/r+M0Er+cpVmJ6zIK3NqAVgU5LOg/jX3IaN5pzgrCi4BcwgvdBsMomItXFl0YITjCwWWDZsWdrhuzB9Sjz9CNnr8vRP/0/Tr5eZaIkE2SCTJvEbOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459799; c=relaxed/simple;
	bh=uHWFMjkXthFKkwc21Xfpqsjb5Yk5pcnJDRm1kauOd9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXyZX4SJqT4j3uqvGxVlLMwDc8nBZ4WV5a5lKzlAAMhBViq1g2QnLxgvMTxXY/4hWXbNnr7N7OU6XMXAlMNQbDlJBOOi96UeJN2WAwv6t5e3tpRSxKXD8HU15SWvTBi5tsY7DiPBmH8LZw8vN4iJyt2KPYnrJbKYQ3XWpF3w//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xep+shN9; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xep+shN9"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1651f48c31so6988603276.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2024 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725459797; x=1726064597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m6Q3XqGIlbZjyYooay9Pnx0IaHEWZeV5bCVZM3wfRk=;
        b=Xep+shN9RaXKXkZChCQ7QnpiYt6KV6+UFufseSbDKtKr6Df4egiNpeLrfjgj75AvSQ
         vscebkHJc+VeTpGOIoRlMG3nwJWxiCLKuYrJavstN7aeEFZbSrM9f/nfrCxE/T3BQ5WX
         S7daaVy0np6p4KBViOGnKdk2uKkD6Iw6uUxfFXr5h8oMbFidkctKfF4UJKbciGM19BB+
         SMeWR5AvpqBs3BoyTP0OzeL2HmcCqIDzm3DvxvYu+l3AHKOoJfH73Xi40mSFGdvNvMES
         NWmD4ZlrLcCGIhYBqEJDfqlzz/EBECzj9KKPXKLJ0Py2XCHBhSeeJyh1BfFwwARd/ZFp
         L5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459797; x=1726064597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m6Q3XqGIlbZjyYooay9Pnx0IaHEWZeV5bCVZM3wfRk=;
        b=doPeMfl8SyfJzAI6YTR4a1guCcuV9wkehm7ylPp1QOzh1mx4KPIr8px/ARhLm9hO0W
         M3hUHvSRvoAJOtwBpc8EdbmdWmM7pi2RS3+W9kUP3E0K8+YBxH5OFNMquE2S3zCpEV5v
         eIJKDByGzEBGto2s/qzYREhAIyUc4/9CqAwxP8fcIsxs5HRW2qR9l/MJ54btIh+0VxdH
         pCbxgi6/2tlNTuYQLYBAYSIKk1suZyrkdzzXiYRkoMSo08Qbu8oO2KST9bvdrJAu+pOi
         XV8xVFcM5+NFyUvvZg7tJ0QFZPEQBzBbonISAHn3Zs62P06nUb1wForkvKaNYQRAy4DO
         jrIw==
X-Gm-Message-State: AOJu0Yz/ABa1iPtrTdlkYvQuusyBNnHGv6w2ZKNe0U6VyAVGain4mqme
	5n8M5eJrSR2TNHiHSARLw48Ox6VZkL05C7+KNSj2bma1m127zbG9QfPmjtwKlqVTnXvR2ovJlbu
	lBbJsIV00f55K8dHO8EyK8vmYlg2NbiGVz+GzwXB32QwC8Zc=
X-Google-Smtp-Source: AGHT+IFB5F7DMOWkLKCfWyKdUy8S7YwDbSHdcIxU2ngKOEIFd2UbeJ3ymRqS0hTytMC8ghB8E4xsO9iWyWM25xE8Fhk=
X-Received: by 2002:a05:6902:98e:b0:e1a:a2cd:5d6c with SMTP id
 3f1490d57ef6-e1aa2cd601cmr11495199276.56.1725459796711; Wed, 04 Sep 2024
 07:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
In-Reply-To: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 10:23:05 -0400
Message-ID: <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me, 
	tomoyo-users-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:10=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Until 2.6.23, it was officially possible to register/unregister LSM modul=
es
> that are implemented as loadable kernel modules.

...

> Paul Moore has commented
>
>   I do not intentionally plan to make life difficult for the out-of-tree
>   LSMs, but if that happens as a result of design decisions intended to
>   benefit in-tree LSMs that is acceptable as far as I am concerned.

Patches that add complexity to the LSM framework without any benefit
to the upstream, in-tree LSMs, or the upstream kernel in general, are
not good candidates for inclusion in the upstream kernel.

--=20
paul-moore.com
