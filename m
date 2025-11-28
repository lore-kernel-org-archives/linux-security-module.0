Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC722765DF
	for <linux-security-module@vger.kernel.org>; Fri, 28 Nov 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345259; cv=none; b=WDBqy8IMceai7vHoByLpD/P+9dDp3+XcZ2H1/nTlRQwtHVRzd5yJhKtm5boXz5WzCsbFQpUYyTlq7t5Sk27pmhcdSDXj3cTFu/G/wn6iwbm5Z4nl+faAqPoqAe8fotaXHv8ukDN2aQTUcz6hnT9u9kFPDGF9Cj/4VOaKdSQXwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345259; c=relaxed/simple;
	bh=XxbQfkUQ9ZzhHAmJ/tKoNMQL/f0sMlxZ/PUI2WholUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaaVfvmfoAxRrXLsRdUiYb+bNgWWaWaU5OsQZE2fWw3xnbj5woDr9kmQ/1IA3wG/TvzrDDs2k7kAljEk4jV06nqYvtJBpCrnty+Pj0h8Yd2Mfpbc0ittkJkjMhRWUYPx0dEiAE7VwCzXHiYo3pTkTijAP0efjmiIvb5/aCOIw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F93R8YcG; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F93R8YcG"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6420dc2e5feso1622867d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Nov 2025 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345256; x=1764950056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaPqRVslZ3qKOfsoCfdpNZY5ZgvluHl8z1VcpxZbHcA=;
        b=F93R8YcGO97LJb2pY8col6JCJFbvrpgcrkSZEsO+jez12zsm3f4Pq2mMzoJotT2FPH
         c5B2evQk05UpTSxMcv+zgWpJxJaxSTeldM+u0deaJk0HbvD12mQ/f0EGEqV37hk6TppR
         G+3B5i+wQESITmzE3EM1fNVc4/WF8n/lKyfnAi2G7xIaPcQhVp0ZjnbbKQaPtU0UuRNa
         damXX17Yjmago5cstnTyqSl8N19qhASpP1TDEAP1BSjzYSfFQ4KGUtB2w7JMU7+oDOWY
         /414F/kLJu1BJeuQXM6zZOP/VbcqrkV6gz5qgbIezyA4x/2cU3t1m8kVhfL0I7r8kiSv
         hGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345256; x=1764950056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TaPqRVslZ3qKOfsoCfdpNZY5ZgvluHl8z1VcpxZbHcA=;
        b=NRt8qFVIg8HntFDzDtQ/MOsvTDL0ExDdce4nL44SHjoeFR7Ww2GNWorIcB4BSqADEi
         DFKHnnayHw22TFM0oQBMnzSE+b+xcF095eKq/SWw7fMm+gN2LX810+GIFtKm9elJRj6r
         z66sexMSZtvgD3i81NRVpaKcpzOGj7T/IntR26Hlz/Q9NnJqOkelfO/q3dybHy84ToQP
         F6AbjC66XeCEHvyC3m7eNuMIIxYymE+Zg+dQWGciGCUiv0X1m27ggw1pjrMTZe6UMy7j
         IVjDKnr4dML+I6d8lZliHPbsV9YQWxNXwu6s00FjAGjCMGq7hW1QxjX4O71ZNg9lGQuN
         6NJg==
X-Forwarded-Encrypted: i=1; AJvYcCWarpyabqlbqttpKOStF4kAksghqSmeD3srQAgLBj8Xd00lmvoxftp9fILSf0Eu4nnYY1fDoA0k0SbPoYgA7K0xMAq5Eg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVwzhaS/UeZO8cn0oeGv5LIHFQZ4ByALGy08iWHNnG1Xub2kz
	j3LXuVPYSYV0jbw/U7GXZtbGSdVLAoPIq2mD9FKwIs8qtxakvbIvbFgOUrEgGiB/
X-Gm-Gg: ASbGnctg6dBZYzOd0FFc3stdNqlMtzYtI4C5hyMBHuzB1aAYjoMkuBu71HsW/VYdoHf
	v9fMCd677oZaB2OaJKeo/XVSvQYYMzXNi3/1/5qnmVM6pxiJLWfybH9/mCoZ1HhxPR0qdlfm7nP
	Y8c7Q3X+fvPpJP1Taxy1m1dgucmzp6jgo6S6jrsYSfsfqq7/1Lp4IBMTSDJtiEZ2B12/lBwLl2v
	nSZQEVDEIJfyqqpt+26P757t26WLe03plo6XIuX7dtx+TTOCHDG/KRAs8GvQ9io+EQx1iS3tfxD
	7hGUVmuplKqMjlUSiZzCd24TRZOAgsJ2ltSVbm5E6WwCmPE1LjRK5rXUTnBOay8a/jUtlDesqmz
	Kr9m6bppRD60Q1CP6RjY0WG4lBihWxdEJe5wLPuDX0WcWSl0avgo8XY1/x/CoKObY6rKDYQh16X
	BQhAEABoEtS7laUy/ErCQTw8HeM93npvbleRlstPoeoOmUNfLkciiqQ08Xi1PX
X-Google-Smtp-Source: AGHT+IHVcGRGViCOB60s529sCLJK603yeIWwyTMfHydroS3WxDrRzYia8xPB+c14imZgVSXPc+qM3w==
X-Received: by 2002:a05:690e:1288:b0:643:55d:7526 with SMTP id 956f58d0204a3-643055d7647mr20485526d50.7.1764345255933;
        Fri, 28 Nov 2025 07:54:15 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1029137sm16065077b3.39.2025.11.28.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:54:15 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: utilityemal77@gmail.com
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	xandfury@gmail.com
Subject: Re: [PATCH v3 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Fri, 28 Nov 2025 10:53:39 -0500
Message-ID: <20251128155339.3873841-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126122039.3832162-2-utilityemal77@gmail.com>
References: <20251126122039.3832162-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the core part of the patch series I was unsure about.

Here when a rule tagged with LANDLOCK_ADD_RULE_NO_INHERIT is 
inserted, "blank" dentry rules (meaning rules with no access grants), 
are inserted along with the original rule on each parent of the 
original rule up to the root (but only for inodes without existing 
rules). These are then (by the mark_no_inherit_ancestors call) tagged 
with the has no inherit descendent marker (has_no_inherit_desc). This 
is used to provide the parent directory protections. 

The purpose of these blank rules is to ensure when we do a 
find_rule() on any of the LANDLOCK_ADD_RULE_NO_INHERIT tagged rule's 
parents, we will immediately know we have to disallow topology 
changes on that inode to enforce the parent directory protections 
described in the cover letter.

This lets us perform the check for these protections in O(log(n)) 
consistent with the red black tree's insertion time. The insertion 
penalty for this is O(depth * log(n)), but this is done only at 
ruleset creation time. That is somewhat more acceptable in my 
opinion. 

Additionally I suspect keeping all the rule tracking logic in one 
data structure helps with cache locality and decreases bugs from not 
keeping the rules in sync with a seperate structure. It also reduces 
the LOC and complexity somewhat. 

The previous v2 of this patch used a complex (and buggy I found after 
running the v3 test suite on it) xarray to track this. The check for 
parent directory protections was O(n) and insertion was O(n * depth). 

My questions for reviewers:

  * Is it acceptable in this case for landlock to automatically and 
silently insert rules that the user didn't explicity declare?

  * Should these protections instead be implemented in a seperate 
data structure?

  * Is the performance cost for the current  implementation 
acceptable? 

Normal landlock insertion and checking is O(log(n)). For rules with 
this tag, checking is still O(log(n)) but insertion is O(depth * 
log(n)). 

Kind Regards,

Justin Suess

