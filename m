Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452261;
	b=TOF9A3DaPNa3lkVuTA4sLevJZGaKhWeiGPRR6ZLV9hCXElRpxTsgN23feS3N0OybZ3F9
	 uRYS0AjqAYL+OZ6arCAuitZsdd4K8wNUhoo/ZNjkXdMKMNtkF9RiqWD4ejByo64dG8Auy
	 9zdCFb4UfNxWn+zZWZEJaJIFtOYOhdyM1ODWfzV3qncQWaPIpTUYZOg+LlOeJvCE1X7XX
	 Ih8xBwEnTzboADDrV94G02h8bXNryz7sArfCZdq+w09hPapvvUD5nImUdr7oL+OhY2nUn
	 M81J3DGW0fhCjYNTop4yL0TYLa9XXqHum7rJMlCSIziHk5nKk5ywezCU91ynFlWs5gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452261;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate:X-purgate-type;
	bh=+j8NlTDkaSolKJC2T/OgIC4R3UPkUPvo0idclAridzw=;
	b=x0J49CpU4BRS+Gd97eJ9qTTeTOgr1iYI2h+SAxf4aaFqiCXeMkGBvfwqbbKowsO5nAy6
	 uqM7e9DG97Ew2FBRhHP2eZ26R9mEjjjthEZtn8UUomCUU90X8tv9faif5dV1F0EyzZxNH
	 BTxG68dJWpEMOEzEpj7fGCwM164kOR11WhZ3qmN7IeGdGhZNm8nuxVGRDQBVvasU3hksb
	 1TiPsMMNHs73SOy06wZJ3khKQGHB97IE10Ku+QcxyufzsspHrV05nCawolRs7DLK9KbEk
	 w/3tbXH9f32WazTASpUV9Zds5JqRUBKheudwgYTrxSEGkvp7CbNd5qlCVP0gFBOg9xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=Y4klHzNh;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15B606A31A;
	Mon, 23 Nov 2026 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A15B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=Y4klHzNh
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVX9D-00GtHg-UF; Mon, 23 Nov 2026 17:44:07 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVX9B-009xa2-Pj; Mon, 23 Nov 2026 17:44:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795452245;
	bh=+j8NlTDkaSolKJC2T/OgIC4R3UPkUPvo0idclAridzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4klHzNhRpNdJtjtlMPEEhin3Zm4SRR/9BU/KQ8b07eaLwlT2b5T7Jb79KXl3RNrT
	 lqQFNPbbJOoCI3ZW29fke261imKo+P5PYfcSM5Kl4ImAzcFOswVZAhnPaPCwHPjw2v
	 HrXpKH6dyS9/dSthjbLw0f+NJo0wwFUMGRkOudOtn3qaVvv09dWgtSLIJAZK6th1ut
	 MIo8JF7vOUHuiw9oytM889tcfBbw98f4PntmWPrIy+oao/lj51plBUz+FgpArjoFDK
	 +7pOMLhvmllnoCmWWaqfS2i6S7NL9F0qN6M0MxvzWxlPdSOIpibE4afyiNpK8AcQ7F
	 vjUjNW7YiK2Ew==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0A213240040;
	Mon, 23 Nov 2026 17:44:05 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E789E240036;
	Mon, 23 Nov 2026 17:44:04 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 905C920059;
	Mon, 23 Nov 2026 17:44:04 +0100 (CET)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Nov 2026 17:44:04 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: shyckless@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, stevewong@hust.edu.cn, kaixuan.li@ntu.edu.sg
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
Organization: TDT AG
In-Reply-To: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
Message-ID: <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795452246-CEF60E18-DEAD8124/0/0
X-purgate: clean
X-purgate-type: clean

On Mon, 23 Nov 2026 01:31:20 +0100, Suyuan Wang wrote:
> x25_make_new() creates the socket that accept() returns by copying
> fields from the listening socket, but it never clones the listening
> socket's LSM security state -- there is no security_sk_clone(osk, sk).

Thanks!

Acked-by: Martin Schiller <ms@dev.tdt.de>
