Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=61.135.153.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317338;
	b=sCnzb07HQOobwDNQuNdsvmXwt9R77offkAxSFVdpfqSRwipjPPfbaD5C/xWKIr1hzzfd
	 gBlVrkxZAaWRiEsb4j3ke12xBrUvRGZTvH2jb7ghe00JSA3UK768yuRmUGKt2wHnir9Hb
	 4E2OJaWvWjwDUwg7KYFWle3lS7UMZ+mf1n/pJxYSE2H5v/Cl1SqGl4f+qK4A4jXT9lk3y
	 X1hVrX9xqoeYvT5+Zg9JnC+ag4kVg2hM+je2lviyb61WgwzqeWpp+qggfvOa+0uO3BjvX
	 oY4wtFb7H6v0OppCcqk9SH2yHsDsAsCP6QQIGjNzP/oBIO6AB1OAMNv++XyxeSUd1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317338;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nrvka/sQHSsmHaztz280hFS6KyrceCCtDg9eO6J04Sg=;
	b=aNcXUlGmddZFHxp+4Tg75DC6M4xILmEB0tJU8yKyH7Y3txMJbnHDlgfC8zt5STGj5mpl
	 2o08/GCmX2DLXNssKIGwaRnxLZuNjx0e9GbfH5W7rY+0uXJ+mULrbqtCPMLqAe8pbrAHR
	 uGJvhmn6QTgIRC2NPPKs+y6T2IvQGg2bmTB5ALnBS+YNo+l7Ty/f8Kq9xTO4s76GNBQ24
	 8hUZyvOnmwsOodGZlN9Bdn3XgMpEH1gcdaIhZtuTai8HyJwfkAwgghBmhm/6bGDzTh0t0
	 oKMooUNeXmRdFXZUDaQyZFfxVGMnvzVsUODRyjzFgQMMnwGdJbP7UU/BGB0Ebwzd/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	arc=none smtp.remote-ip=61.135.153.141
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24360606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 23:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24360606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793317328;
	bh=Nrvka/sQHSsmHaztz280hFS6KyrceCCtDg9eO6J04Sg=;
	h=From:Subject:Date:Message-ID;
	b=h6ozoZk4tBcP2xbFXM0MfAFwEYcy9iQkB272CCQSyLkyP9ciBU91l+SXyMGzLgAu2
	 /RBvRlamIL7lJhFgOyDedSIDEFez7okD1GyvtFBaD9PFk45/r963MWqI8yZS6rgEUZ
	 2pDatahBDzNed5BZ8N6DuyPQCtUq3nStSQ6c17Nc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.254.2.154])
	by sina.com (10.54.253.31) with ESMTP
	id 6AE3D9C4000031A9; Thu, 30 Oct 2026 07:42:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 346596816134
X-SMAIL-UIID: 9D7A95AF643B4E1D9E2D718F313014A2-20261030-074200-1
From: Hillf Danton <hdanton@sina.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Date: Fri, 30 Oct 2026 07:41:48 +0800
Message-ID: <20261029234149.218-1-hdanton@sina.com>
In-Reply-To: <20261029172918.2118600-1-jarkko@kernel.org>
References: 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>
Given cond_resched() the gc work is not a cpu hog, and given concurrency
workqueue can get individual cpu highly overloaded in short time, so what
you delivered is a half backed croissant, HBC, as you failed to make it
clear why lockup occurs when the number of gc items rockets up.
