Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738D328635
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630246; cv=none; b=u5gIK3bAevZyVGRipMssIhFA0KacNCMS2Q4szz67Ftpryere67Lgpgvcgrosgv0PMYmaq+RlDpN2CQP57VacTArBmmwiCk8apWkODBv55JOFk/IIwwmwrr62J5oFKXmXjk5COmbEk6rmkInJ+Pt8z2O7vrldMraV+sTk8daiBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630246; c=relaxed/simple;
	bh=ffwyycNGsHUYL30inQKYg1B9vqvK8ooS80/3W+GE+zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BTxErUhSIV9Gta64IS5sdQb1MEqaxXZJ0GKSixZYlNUNnZBC0yfFNC1NZ9wCwbhltIcr2MZE0DMrDLvyJKNYeCE/vh8ugNXWtW8ZJUzWEWWro3o+ouGviXjRPZS3Gtb1Mx5tQ6aZRoDcCMhSxRDap/+kFKavugJbxs1f027RHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edpioi9G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edpioi9G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee0291921so25607295e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770630244; x=1771235044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCsTGNRwCHOXdV60evM4B/ieoAWEQi135YEapFnAevA=;
        b=edpioi9G1pzbSrGaGxgg/YT+1Ush1G18vTy4p4L50V1vyI5j+FD7RgQMwdlri9m8x4
         2kWC6LJzqav1uoTEc6vw/m7NLwofsQgCidC5b9UeBR67uotTS4QHa2TbYIvGXS+nZpfx
         kHgpVP7HGWaR6ZSSJ1PPQ8clhBWZnPJwl2uhzW4zjZ11EMOOKm2C1LDCONzCT53ZJ8WP
         y/1+JbzSX8YSoYTajI++fJDGxoo9Njb8yEXqUL/Ig0IXJpPGCAR/uifjW6wMWag/eLmM
         /6Y1U3Vi7I6IVvPJr4aUHu+0xf42qrmdegWSq7YnodWl5a0NPvAY/26Y/pNoNWDSZZxV
         8wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630244; x=1771235044;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCsTGNRwCHOXdV60evM4B/ieoAWEQi135YEapFnAevA=;
        b=adYS0hx8EELOqWjyof1ayn7rbaeDRcRLj+KowlGxSV/1xhMYlVra/qkit0YJtuteJq
         RtFXWSBKWRniosnT7BH6IMDwMPsOejNI7xkiAookHZnNV1ptYsVrSEdDTUDSIamhcjkc
         j4pZizFK8gyUkA8ZRkYboU5/daxme4zTmhcaVJ5rR1/UEnLArO1/kBjapv/J6jlUc0f4
         JDBhZGONhNe1S8ZESAPFlLyFz195XURRQVNNwKS6n/31401yG2lHWO/QJZku6upxKUQf
         f9M2Qy0ckSe/ZoBNmQS3w3J10u5kBXUcELVXyIsJ0qm2pPlS88+lwhdSjQPEIfsBtuOG
         hBog==
X-Forwarded-Encrypted: i=1; AJvYcCXSz1zFVyGXTStrCIVYrcntHBO5yxJl1diS1g91gBVdvg8ZDXmBzse7miNo/R1U7w4CXAwPQD73GrWsqg8SwS3xeK8bkqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkArz/kPKWTHRBxDy0E67MZnfrMxnmOzcAKuKAVgEL8TlCA4ms
	zZlKNuZbBU7ImoztIRsZ6GL7wijsCDFyzC97R1H3jUvSG+orZKSIuRgbceFTlnEVQnc=
X-Gm-Gg: AZuq6aJz1gFcXaWc+nHaLlN32f3/FQjxle3QYGfIAumRQR4pko2g6EPBBEFdMByidgL
	tquEYcQ4u/leSdJntabymlFRwR2AJ67xyQDPpYhy4hGBeq0oQa2rSYgXp+lguzsT3yRkdu2tf8B
	HHJAHGyEdMd6ldXJ+bKF9pzw1ewlagUzK3guBt4sAceWJpANxQOHMH04ixDjzN/pDEhB4TE35Qz
	nxI4ZsgQ4zLkpwVz0UldA+AFXTD5PplS4d2R8/QfwiMqwVYo7SJJOAyA7IfZ1pcdsw7ut3IKLk/
	P5Y4idK6uzzGstUJ0tWB2arSAddQZlAQUhPXwgLw4/0kq8pw+DcJMRUffMJFJOEEcVzlRuNNGIU
	sLzrbonhhY1BUayAPKHHsen5mXgzFdywniXMlURC+zQU02J9PU4wIoOnCjRwJwMtwB+RtHdgjHR
	HHohIyGVd0VQDmvNTC
X-Received: by 2002:a05:600c:6290:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48320226676mr171207675e9.34.1770630244378;
        Mon, 09 Feb 2026 01:44:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2ba61sm480009135e9.1.2026.02.09.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:44:03 -0800 (PST)
Date: Mon, 9 Feb 2026 12:44:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] apparmor: add support loading per permission tagging
Message-ID: <aYmsYRgv3VClpkjX@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello John Johansen,

Commit 3d28e2397af7 ("apparmor: add support loading per permission
tagging") from Apr 1, 2025 (linux-next), leads to the following
Smatch static checker warning:

	security/apparmor/policy_unpack.c:966 unpack_pdb()
	warn: unsigned 'unpack_tags(e, &pdb->tags, info)' is never less than zero.

security/apparmor/policy_unpack.c
    951 static int unpack_pdb(struct aa_ext *e, struct aa_policydb **policy,
    952                       bool required_dfa, bool required_trans,
    953                       const char **info)
    954 {
    955         struct aa_policydb *pdb;
    956         void *pos = e->pos;
    957         int i, flags, error = -EPROTO;
    958         ssize_t size;
    959         u32 version = 0;
    960 
    961         pdb = aa_alloc_pdb(GFP_KERNEL);
    962         if (!pdb)
    963                 return -ENOMEM;
    964 
    965         AA_DEBUG(DEBUG_UNPACK, "unpacking tags");
--> 966         if (unpack_tags(e, &pdb->tags, info) < 0)
                    ^^^^^^^^^^^
Signedness bug.  unpack_tags() is unsigned.

    967                 goto fail;
    968         AA_DEBUG(DEBUG_UNPACK, "done unpacking tags");
    969 
    970         size = unpack_perms_table(e, &pdb->perms);
    971         if (size < 0) {
    972                 error = size;
    973                 pdb->perms = NULL;

regards,
dan carpenter
