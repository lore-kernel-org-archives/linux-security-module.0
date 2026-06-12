Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217D2288CB
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226684; cv=none; b=VLritBYTCTFBTTfXHTYzD4OPARbMWGlp+8x5b+A+GsdXqYv5ViF4/udKTyBg5zIOBT2/2VCJk/1uqrNO/ufVra6sw3o3yBsJleKM9uqrriGySZ+O5nM57Ax8dDnG1g8K5yAtNjoYa/+q9cySC+QZA+7VrX7ZiWt+OZuOMOM9y5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226684; c=relaxed/simple;
	bh=2g+sJPJKfhVb0nJtLgB1yVbdVcFn4C1Jxj0LPu6QHCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS4UeZH4/Xm1TOXlby/LEHDK/LlvQRJOSLUvDnrJIHCKIkhbCHF27IVD1eU+coujUfOLBmKuzw0Ynr7GrkgqGMmU55lT1C3RMlWxzlEY6T2VaYZuJoNRVVUNY4iR5PYbyBDlxKyEzIaaETKslsJ4rmHqPd0E9RSjDMQC5QBVBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=xHqWDGcS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBwSJJnm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="xHqWDGcS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBwSJJnm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AF5F1D0014A;
	Thu, 11 Jun 2026 21:11:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 11 Jun 2026 21:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781226681;
	 x=1781313081; bh=UwMsejahkjSgTEcXYmUdZyYBnrQI3urqemZMcqrSYk8=; b=
	xHqWDGcSB6gTYeq8ltPMELhjt9qjJD4EbPr//j6OAQ9hU3UzVefXJ6WNaCODVwpn
	6Arid/8KrpmzEYhhCbOuCNP2Yh2rRBOTtlcB9JMM01SZIiEIMllMxLYoMdu/EFvg
	jY5WlKTHuiQbIIc8fF4l6zITJMrTP8g7v7RqLuRZdQQN8H3JkjImb4ZjJA5aP8Km
	6R3rV5IMRJTBBfheoNW/oG3AcIrBtU/zwgkfSKnEl78vszlirPzTfBOGxQjRQeIw
	kEldPQkNH6UaRMVApdRXYTXK84YqHEj7G6i7o536cilA5qlkq1SvgdnhGH602J9A
	CZE5mndVvTCC1NpIKPNhmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781226681; x=
	1781313081; bh=UwMsejahkjSgTEcXYmUdZyYBnrQI3urqemZMcqrSYk8=; b=M
	BwSJJnmI/ogERZtACLhJkzOlqx32xHPzJQFuyqAgxRtz2wyxijCcAJspsOvTcBwj
	Abc82+YtNeNc6clptvzKdFOUDrewGCrbmVP+PgP07D+2EyMPjSsQAfYZyXSGgKvR
	PIyjtMlvoCUfC+eHx5M7qCzhYcXOzOOJs3FnnZUeewFdfTFQZepY/pebHGw49PzB
	fENTh1gXkeXgoH/RyBb+cdXjoKG80CsJEdb6klckuEzL0rjSPaRkaAX7DNIPOokk
	9rUQPch5Jc2YUM2HbGmHYPYIimqAv6XZ5WfSVgxSBXUrUXEmqnURdC/0Z/KWvv0w
	T0KA0dtAzHmy+m+m2K1lQ==
X-ME-Sender: <xms:uFwratC2v11RW8t8gN9PY2YLmp3Uvre83unbgTNt0QjR8k6sbjWvBw>
    <xme:uFwravP3EAhrOq_iEsv2xau4_9hASsBtDKMx2m3gfCLkhHIpX1GlxycY3xiN9oupQ
    2STc4zsa_HKUryPcJ9nY1eJ9GZFFdj636yMKmLrH3iVR3yBBF62d0Y>
X-ME-Received: <xmr:uFwraiY_xURPUwvIuEiPO_obrtP0SVyB9CdpGMf_1y7eZo5SAqiBYEgLpeoJmU_uh4Ru6uqd8wt3FP4Ldg>
X-ME-Proxy-Cause: dmFkZTGuga57ASTq1XCY0k5QTsU5YfQb+RgKw69heux2FNzmis6sCx04mcMQu9epbO+3qR
    myxehSa3IYDPWeHYfmXzrbvnIBJX2jM6MxxNzH1bmcaMNCz59zUEICOCizN4pi/BLzpQ1k
    WcOmS21lZF/JnLtaAhhM+JaQ7g1EZEPJ7sjwQlfbvHlgT31GYaEd5WCfdCCKWrX/7GLH3b
    sv8dTeojzl4dKhAq7g3q2LroUyO/KW6+xj/LK66D4UYT7FPb76AKpzBM1SY+ITaSgHwfug
    2C4QVoXXO8aI+/XGZ+02Wn/x7vVF2WWOBso5vhaC2CZj1FrkAiqW64X4xt2KROLW7mUwCY
    kGD5uePgmPV9u9gOiSKyY9drmeT/MaW82L72MiCOJo/cADKV+A47QUqk9Rmo/JuKWj4+Fd
    EhM/RUYTzJtVDL1IxznsRAgQqby/AmAM2JyFfZtabsnZe6zOC1NMEO6B4ltRkhOz4+oYM/
    y0zE92tbVfnut+lp6UhbS/9OWxMwTbge+A3QYBzfJkXCD7tcPP1NR6kIX+JJsz5pAFAg55
    mCx9974Wm8mNBeB5oJM6sJ2TNCuGzHWsMqSz+LBwaRTr0JQKe6LlkleT50E2LYD7EYUO/O
    fT2nqUo2yynZhCSMpmrZmd01AELAwQ0etUO3u4ujJ3KehmekKbqGaSny1yfQ
X-ME-Proxy: <xmx:uFwraut2rY00DRUXY2Pj_8O3CqamsrX0eX8_R9yM41K4hk17T4tjtA>
    <xmx:uFwrakOTzPx53OQzTV2LTwOx0WAkohgEgGVZp7QQjVY-6hhS_-lcKw>
    <xmx:uFwral4EXdpdZlJnCj18xy1kOymG_vGmR7p_T-LJFIfX4CMIviRfsQ>
    <xmx:uFwraqTGNyQ324-14B2Gq8X2N4lpI9fZuMrFybR31bNWBRSEW1S5bw>
    <xmx:uVwraqP7bu3ccGZJef3uTP8P3aI-yRy37Z-E7ORUpb8FFziDp1TCeDlm>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:11:19 -0400 (EDT)
Message-ID: <791c7404-6481-42d3-be8c-dc8bafde0054@maowtm.org>
Date: Fri, 12 Jun 2026 02:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/9] landlock: Add a place for flags to layer rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1780272022.git.m@maowtm.org>
 <676e38f1c2d3f6445bdcd45be043e514f6509a3a.1780272022.git.m@maowtm.org>
 <20260608.ni6daelae9Qu@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260608.ni6daelae9Qu@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/26 23:40, Mickaël Salaün wrote:
> On Mon, Jun 01, 2026 at 01:00:35AM +0100, Tingmao Wang wrote:
>> [...]
>> diff --git a/security/landlock/access.h b/security/landlock/access.h
>> index c19d5bc13944..42d8b5134358 100644
>> --- a/security/landlock/access.h
>> +++ b/security/landlock/access.h
>> @@ -62,18 +62,39 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>>  	      sizeof(typeof_member(union access_masks_all, all)));
>>  
>>  /**
>> - * struct layer_access_masks - A boolean matrix of layers and access rights
>> - *
>> - * This has a bit for each combination of layer numbers and access rights.
>> - * During access checks, it is used to represent the access rights for each
>> - * layer which still need to be fulfilled.  When all bits are 0, the access
>> - * request is considered to be fulfilled.
>> + * struct layer_mask - The unfulfilled access rights and rule flags for
> 
> This struct could be used to store "fulfilled" access rights too.  The
> previous description is more accurate.  Please keep most of the previous
> description too and adjust as needed.

In v10 I attempted to move this description to the doc strings for the
fields, but happy to move back (done in v11).
