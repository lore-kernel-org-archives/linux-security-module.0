Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B81318152
	for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072424; cv=none; b=q+CH3yB7T6D9qxgYZCpjdSupUUaENtLy2s8pZsN0iNcaUPUEf4vxrSL/s14L2cVHWL0o/Yfu1eIpHt+f0pgyqhO1vXCrw1FCTFqoFuHvfLky3/S4E5xbAMSkr/lFS8HMOlW9MloQnombv3mKV1WobK5yKCY3Zd0XUYuExBdv6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072424; c=relaxed/simple;
	bh=9chMw4IatMNp75kGacjv8tPcIcOsFOFiGsoPeUtZTqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XApCxfHMmBRyhfgR9pVdq+qiHgtYSS2BC0FPsUX+Kp+ZCOyvorfMcgNnygcjvQkFwM/s9q9oYfMMgVt6cLuSVRAnqRsz7sgpt1Zf45FdacPPDlICojz1leMTg2YFGb5l9ctZtGJB2JEZg3SGKGuYyE+H30f/K+BrVK1c5zlfLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrGdx5Me; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrGdx5Me"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e19642764so3987169d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072422; x=1764677222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9chMw4IatMNp75kGacjv8tPcIcOsFOFiGsoPeUtZTqY=;
        b=XrGdx5MerQteMDrcjIqN7kjOnL5LPTV4+W+KHU3Gj5Qg8ZyG4bayD/1kBy8uw/22y6
         ZgpoajLeRGSvD4+w7F8HJeFRQh5teWznqB9QeFD5r3qDPYMIRfO9M8M5Tuo+jHdZLAEv
         hMTiu8QN2l3hajaLNb980B+RIqYgh7jsgO7MXrUVQsr3a0dcMTv7wK2Am59Adb+M/WEh
         AJ1DlMwz4Sdtxquui5oOmAcegxFIzXkSFAF2uDQUgV0T9OT/BrQu9i+r/uZKFIRBSIaN
         oiGNpUOFTI/6c1C8djxr1iN2rUkLBMUNZUnU31OH8KbvZ7/WGWFhyVV6cBDIFBFwiQi/
         ovig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072422; x=1764677222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9chMw4IatMNp75kGacjv8tPcIcOsFOFiGsoPeUtZTqY=;
        b=LcnjEhAIex0pJyecHrpq1s8NemdiUNA24JmemXodKbNgiFJfMVnmUIkaQRQIn/ywNp
         CwvY3zoFiCJugmZAcqnrmtpbC1fzAmWGJJLeqA0giItogcS0p5FbRZJGT1eD9Sn9d190
         rXawr+2svRqy5ucGzKG7OSgJbopJPqlz6xdoyuwtPqDAoGlvG+IhHjV9GnZB5MMFQ5xh
         eTtqXOsPZO7H+i+wTZzhJaH7/geHkCBduplNGDRlMo2Bv1tR0B1teAzU6bSr85S9cU7C
         AiVRxDJy7lc5URbcheF0cXHccmGjzXYFUwxMZEq5k+V+tTbWyHeG3YgK+BmVADGgBUJj
         CEhg==
X-Forwarded-Encrypted: i=1; AJvYcCWRK0LeP7VqOYMnT8LrvLbgLJb4j0DzGXmWss6JtK5a7Xf1ehAFbFLEBCEGMYQBmMAq1zhW4H8YkSWSRS/yI8WGhzqRX/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkn/uApQhnZ3wzSojnuNuzHIV6oaKbcBfcRDTiOzZXGJ9HshV
	EkGhCvpiU202cRooDV9aVjNLWqJhYOX8woOnj4YEINFkCL47VKclhj01
X-Gm-Gg: ASbGncuKf0awwzxCIS9FYmg0RMFqySYHzw2pONYo9MWU8mwu/q5NVGl54ZvLTXCdD7C
	rjwpmsQYkXV2guzGE5eJf0VjyIsD+7Nvp7eSzsUV+86kakLQh/Ptzqn4or65GhfkFSGrhuRIm/m
	/leXxdwu8D7sNIwtyxRDC2Z9WjKXiGpLd/mt5NXMBZ93yNiOMn9qq69nQdZmOyNUyvWpXxTEK/S
	a6RX1+5evvxK+3fDCijJ/hH4vXce0pG/FU6/DHm3ajbhBMXhOPKYP34W+EmFJ1knaAPgUqbAzDv
	NUYZY8MKIC4i4aQZwvqTbDi+OF1nPdF0YUti82kaDX5lIFryLFGb6gAch6t4M+PFQYJWG5avuxr
	awLXsBwarTNO/N1ppwD8oXOMAYdH5SaVKXqxa/7dACRiJkbcqWjXtfIeX9W40G+ZF2UmzBQSynn
	ra5+cLrc+mDRMK8NMwNIeO0Aqdvcr1aIv0Jnpes6vJwjA4wA==
X-Google-Smtp-Source: AGHT+IG66FvNWRUd/v2kQynSjrsiEHAh9XoMgYGNCai9L1Z2pti6z1ZUtNTOiQ8otU2MQAyiMqNsXA==
X-Received: by 2002:a05:690e:11c6:b0:63f:a856:5f50 with SMTP id 956f58d0204a3-64302a393e8mr10494282d50.6.1764072422001;
        Tue, 25 Nov 2025 04:07:02 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f70b1dbcsm6025501d50.11.2025.11.25.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:07:01 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH 2/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Tue, 25 Nov 2025 07:06:52 -0500
Message-ID: <20251125120652.3642089-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <59aa2857-46d0-4527-990f-03fd6bf13305@maowtm.org>
References: <59aa2857-46d0-4527-990f-03fd6bf13305@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good catch.

Probably just gonna add that comment to the add_rule_path_beneath
since LANDLOCK_ADD_RULE_NO_INHERIT doesn't really apply to networking
stuff at all and really doesn't make sense in those rules.

I may even include some code barring the flag from being included in
irrelevant scopes.

Networking, sockets, and signals don't really have an inheritance
behavior.

I personally don't really see how this flag could apply to any
other scopes but if anyone has ideas I'd love to hear them.

If other hierarchical scopes get added then this flag can support those.
Or maybe this flag can have in a different meaning in those contexts.

Thank You,
Justin Suess
