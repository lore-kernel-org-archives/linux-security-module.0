Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540800;
	b=L5dBL7sJmOZC0Dnip0mNIuq0Vl3zTfn6M0FaVIUjEtlttf03TqbyH1TnD9dv4OWVYFO5
	 G+cBjbtaKi1dIQ8T2yYtmjTtUNgXiRWaRObXNMBvrYzfyxMliqlwo3N36+tvcguJbcZSg
	 IU9CJyHAPfy91XIN0vgUOo8M5HUd2rVDYnhlm+5I6WbJk+tYaPhXuErxcnHrw9L5mf15t
	 qGGnOSL2tc7TC1RHjc1UYTnhO6AxMMJULNXEbzGFspqsFh/R/w5FVN61zyeXV41Ljv228
	 5WKF9adomC6ZqdpsdVluOZRK7G8hZT8o/1jlLg8RKWla4sKTTL5WESFqOGzsv6KG6RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
	b=nvo0IMSzuUwBoyJ8GUprjAh7JuBHK8saHNmj1u6wwMYYpUp+5aICsHyN1W26jYQewfcd
	 Ig0PH6ziqXLrF5crKjMymJwbgzMVMrcpf5iMJHphafbczKm+++v6jSLRPeceseEKqO7sW
	 iWMJwwB9JlNfiqXckjrJmYz39uI1ESfaGn94NaDMcTMk1oChG6p5pjV1zmdpI3M6y/Kc2
	 yfl3VogKYwxKvmVmy5Afcu7byDHPZBGp5gcplcPG18bF29L/eWOSWEM084ibLAOeebf6r
	 ThP03isSObr7ckCXX0wqF21caqbIshXaYPQ1QCxQkqFMS7qznaN4uCjjZg1D4mP82Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEdMmKAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E6606A321
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEdMmKAK
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49412eb1474so3108638f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 09:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540799; cv=none;
        d=google.com; s=arc-20260327;
        b=CbefCJd4fgym3ctlC+nWSDt/LhpvZgWSTgXX8ynrE/V+bMt5WQnr7ba5WlptZvgAxB
         Fu2e7qfgbvgfrnnpJiascJdPdskdd7leAxgMHe0uhyDvBb3FCQ/K6u3ihgyVijq2P5rp
         UETuZNJKXgwxvWy3ip3mL7Q0j6wbtlWlcQb1rhahh2r7qCXLz2KuB4XZDm93r8iVriZu
         FLB58LAqgb8jrIFJLUruRUzGUkxkDZeqW+BKGSgMd3yrAHXRb6OUhGDBXZGsYIyJR1ho
         0MxxRBpll0HSISMDIusIS5X7LzLDtltdEgKoOI7mEFyaE28onyZquneh+jWD2bwWrlKB
         FKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        fh=I6XcZmTAMWfhl+QiS2gGiyNzS+TnxeZUi80ZBjaP8Oo=;
        b=SQSzTxuPCDvuOrH9PTw/FhU/haMIAZfi/OOueIv8f794mZux93k/5fxFWIj82FqtQ0
         EiHP4dTpTmqmPHNrkiQ1sQR85VQMTxww2WgLPCzdKV1FmYH5oZbv7920F3jDAws4QXmu
         yQTujbtJDPDLkM83uEdc8nPQlllKvB1JYg5WnCX4sJoTuM3/2Jmdqj9IsApoHyNt23B+
         I3Yi7hTOXWkppko6OTWFH3/TLWcv240qfFs3h3OfPL0hj3qS92z5dI2nmXa7RisAopIR
         UUpMmwcurocmBDBvIoZPoDSOJ4cI2+pt0bvfQwYqKyPX84YMz8MRagIEb7qp3/6LzPdN
         PuDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540799; x=1796145599; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        b=sEdMmKAKvHAF6+bOEUrtKd9w07tUhTwyCvIlU34VldlORSo5/94WD4gjL3zIgravLX
         i1VWQCmyD/L5b0ICrRoSFWPGmePK6nm38QkNpgKSfWLCunId7wp3XMz/eg8Skqivz31O
         LvcjGiCbIGKLDETBg3RWXHAVzEUE4aRRIZYuet0jE2T7DBNy1SrtreXLoX7ZJOKPI1yV
         GfHI6F2FbzyOUBrk+LyZGyKoZ4Sk65y+9FAaXOrInNvB9h72Fe26mweN2lVZ04w6Jyif
         VYdW1udaWJjDXehNqpTiR8sTi92H5eRe+btzKG7KxYNzAUZRoxVPUjWGPdA9ltPsxrSl
         nXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540799; x=1796145599;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        b=cZhQI0sr3pM62SbjGDeyqB1q+zkjzLklmJNh6Rs4oVB9UX6Il79uYqWK7GP6kRjoDn
         MsXT9uUHsndV5PullwWxH66n+ARiaCLsAhC2aY20AULOPiR9VYcIvqCN397mUNAlHKhU
         jw1I5XIQOwTA3qeT5tF2faIF/tNyWzbugdaRr/r1YC1DGjoQGvaorgyDpOXVj3xQMXBb
         lVEoonHd6hfv0lHnZYrQ5amuCasLmBR+pA6g7bIqg3TfDDJx0pd4SjxmPrqDoH1N9Z4q
         +N9StHW3V6oQYrUvlyl/YWc9gOsFpLkPdRg+cySD1UsRPbLh3J1Za34gE4prr5GeqBfo
         fHwg==
X-Forwarded-Encrypted: i=1; AL+hErGaRLejLUaLwQBf4hpYoEW8FGo9AHX59YtnR+Jotb7q7gTNoz7ZlvpYfc1kvfEPzDxjzmUqcVbE0csXoj/zuVL2o1S7fgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ks/fK2uLtk8zUyjF0vT/BAQDOBGVCuTEwjP06U+efaVQNG0jq
	B+cONoGooFeUr02LtUvQgP8D0WtSM0zJDirKEeEZz3ETnabN4b2e1Hvw1cUmg3erSvVNJNQniuB
	G/iDp4kQPVbrNBAfe4sFKblEN3JID7CA=
X-Gm-Gg: AZFdTZe7hjFRukN8S4l+0refH+K/W5jtaNV/L00Dsuh8JLTQzamsfpj7Ks0KWfL+TRy
	U5zqKWUS5+6ptTmBv8p+KL2mKrwERqtL54hIA9gyQs3VuH+Knb0CvOIjTElQWgVEWU+Wa84WMtX
	f9vBHnC4ZuL2K3f6VCD+//E7QTfXZKCDrkMrXqSCWZ4bVrmk/RXl8UbGIMH40gdNrotuedpNw6k
	RqxYdMQYQ4D+WGVpYDdR7lRx9iUaePzC8N+76OznwLBOJkQMBYS94Z8pl+4u6WFYXSQh40DCzTv
	wApyuKJY9dPiHD3vATt+ty1ygOGCUiciL81EOFwuyQqzvdyHWSP0dwDS4W6GBiFDcCmDcGpM0X6
	pjSbyNXyB1xBIZafA6EMMbL5xAQwf4XZUULo/2RK6iT/HEQ5ZoLgVlvcmGoVy7ja2uUrhGUGGzV
	tu3S/vpvQFSqm3cSAkV31Egn7R9lj/bW6uH4937Lr5CetiCZH+sYI=
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr289651265e9.34.1795540798527; Tue, 24 Nov 2026
 09:19:58 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com> <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
 <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
From: Wong Steve <shyckless@gmail.com>
Date: Wed, 25 Nov 2026 01:19:46 +0800
X-Gm-Features: Aa3M54pfCokUKhl-I0LqSXGVHhsd32oCkVf6bc_7JRKNUQctTjfAfWYnwD5gTZs
Message-ID: <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Paul Moore <paul@paul-moore.com>
Cc: Martin Schiller <ms@dev.tdt.de>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"

> the x25_make_new() function is called by
> x25_rx_call_request(), which as far as I can tell is on pretty
> analogous to an accept() operation, is that correct?

Yes. x25_rx_call_request() runs in the receive path
(x25_lapb_receive_frame() -> x25_receive_data()) when a Call Request
arrives for a listening socket. It is the X.25 counterpart of TCP
creating the child socket for an incoming connection:

- x25_find_listener() finds the listening socket,
- x25_make_new() creates the new socket and copies the listener's
  settings,
- the new socket is queued on the listener's receive queue, and
- x25_accept() later takes it off the queue and grafts it onto the
  socket that accept() returns.

This runs when the packet is received, not on behalf of the process
that later calls accept(), so there is no process to take a label
from. Without the clone, the new sock keeps the default state from
sk_alloc(), which is unlabeled for SELinux. For TCP the same step goes
through sk_clone_lock() and sock_copy(), which calls
security_sk_clone().

Thanks,
Suyuan
