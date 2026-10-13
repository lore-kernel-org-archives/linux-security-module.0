Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE42342C80
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898627; cv=none; b=ptZ0KUZu3EEicEZ0EssJF4fmwYVEl2JKqOZyC7Bb5DgbByoAc02m/mULP8CTWpr81XjQACOsTLjhtVkmUZI/2B0bTsOZLO0RGBxpGb9TlhKT0zlZasyF/xXQdYoqvk5EuFrakOQqIb5mVtHoBHx3tpA188quiuy5DXkbrbnbyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898627; c=relaxed/simple;
	bh=/hCU9eM+EAM+gbO2WZ1UL5JdVd2fGYoXa+LQjApjQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDuSnoXU/VSdTwGG6Eijcp1BFe2TBKxED2wbpudqfs7ItLJQhhYieh62eJ8BMiIimXsY6VAsZoSBE1LZxiqzsx2p6vcAksIb9VBxqJemn7RHVDejfP87y2oHrqWWUM7dzZdDrwrq3MZAZvRN4zGWJcbJOUReHCBj3It+r7N105Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MPpzjFTh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MPpzjFTh"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e56c287b3so237281285a.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791898625; x=1792503425; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hCU9eM+EAM+gbO2WZ1UL5JdVd2fGYoXa+LQjApjQ9A=;
        b=MPpzjFThiloA1rXZ/Xs7+Ba+mlqw222Gl+AL341vd2von9MSnRwrzd9iFiGbSilR/L
         WFcgZ9zB55znMBK/Rzrzti49PR5I1oiyg+ji6myyeUH+GAHOY2YA26zRZ0U/HnSMRumQ
         NI8xIdJdHfQjKPn6H7vGGSEVV5KdoJLTtyu7owtx3s9MNvXPUrIB6cOSoLtUE3o8tZuw
         edAcX/LvBwk9pxMctutv2QEVP7NQTzTDf+DE3uAaq6VyRqd1nC4GkC8zgwD56GZPAiOt
         67JucTbHLZhY11Ovxr6Me9VENTwee8OOs6xeUAzRWN/i1mYXqpaY1HZ4R62BaxOvjU+1
         Q+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898625; x=1792503425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/hCU9eM+EAM+gbO2WZ1UL5JdVd2fGYoXa+LQjApjQ9A=;
        b=U1DEOmUIY/iMc/xytBblvIM1xKL3kKatQdTWJqK8rux0b5yponh1poPnzVzLnQCfF3
         GO2FZT/y3YhWOPlZiVmimXm9hhu+98uI+J5kfFLKuyaJzYgUCuTkX+VRgv7n6ZtrqHvv
         +Fb72i0naMcmUS2tN2OdY1UPQr+HzGKBNvQMOCkGToPriFHVTEHJb0NV2sc43V/CijRH
         Ch84uMfyNso918SVW/vH75sL368T6yUX41I/MVMtYSYqLwmnv7PfIGZHTz/oNI4p0Tjj
         qdyrYUQiiXL0y6vljbI1BW7NFatOmxt79qkypJU6pwPzovDT2+Tf7fHf5VjH8auF3dgU
         lB8w==
X-Forwarded-Encrypted: i=1; AKwUvBz2yhedhz1swOR88l/kjEQ70BNooHLlwF2mnXddAFL128guuHpw3CgK/7fcQiHdJuwNkS5kou8WHQz6x5gnnY10wBYbqJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC/KbKFpD/YVeZcqiBdkqYYf2LgHf5f+FsLJrf54QZ6JOR+0G8
	6dTDcOAjFExOwb7As/2vq+ofyklP9JAcLtFaEy+fPFkHaPc1qb0XSThtRovH6WMCSbQ=
X-Gm-Gg: AYBFou13hU6JtM3de5cEJVDLsZneCI+C1+8QASLV3r+F+TNyTr1ihY4rpl+2hAGlB6P
	PPoLFSoQ5TlyC/8pAREbQEz+3kaXrqwlY8G0KEBlr84n+yzZwa5DPhxZugVxJRg7kGgN+raHnhC
	amFZLkPTdqiLut/MFF5ljKdcyDaDdlIFDaC4ZcdEkPy2K520xa1zmF4wvvr6aXau3KZrfStRopx
	rUikSYCJTR0CGMo/x2Q2H0l5UeNeYYG3jot02C0V5B1gFsy6dDw4HYs+e9EDS8DCiVWNCiRsZpS
	4dUxP4jwamXec/3RHniH55LSPT3oZcPdjKqssK359uHzpJNn1Fd3ZfAs3P7tm5KatkY7V9a3nMW
	SVn+kD4P0VDNiHnUW39jqEyfG0oACk6xxwIB43UeENPtWZ0ScDFuwMBECcRoGgXzL97G3n2PXuN
	HzglGUOf5OIUfU8hiibL4TN8Tqi0/JxCn1x30N8anQmi1jFWr++ofusNYZ/L8iooABHxB/0emFD
	btqPoaflIXiHdqzmMhwP1QiIKLTfpLqVg+Ai++FjyGvxs/fClKEgNAlIJfh3F6f7M8=
X-Received: by 2002:a05:620a:1a03:b0:93c:ba44:673d with SMTP id af79cd13be357-93ebd1b7173mr2238297585a.23.1791898624601;
        Tue, 13 Oct 2026 06:37:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50295a7sm238844085a.23.2026.10.13.06.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:37:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGcgh-00000009eSN-12xH;
	Tue, 13 Oct 2026 10:37:03 -0300
Date: Tue, 13 Oct 2026 10:37:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Message-ID: <20261013133703.GJ14213@ziepe.ca>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
 <ar5tOUor0bp3MtQ6@e129823.arm.com>
 <9e74ff9d-e8a3-425e-bf7c-f973d06e6cdf@huawei.com>
 <as3uzQ7L6tJ-Lu-Q@e129823.arm.com>
 <1451a49c-f37a-486f-ac47-e2ff86fef28a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1451a49c-f37a-486f-ac47-e2ff86fef28a@huawei.com>

On Tue, Oct 13, 2026 at 09:05:37PM +0800, GONG Ruiqi wrote:
> I'd rather not base our work on Jiri's patch at this stage: it is
> a pre-RFC draft of the new attestation subsystem, whose design is
> itself still in progress. Building upon it instead of current
> mainline would be quite risky — we would be rebasing on a moving
> target, and merging would be blocked until the whole framework
> lands, which is realistically far off.

I'm going to be strongly against any work to try and put a ROT
multiplexor into IMA. This is architecturally the wrong direction and
is clearly very a short term project that will expose uABI that will
be difficult to unwind later.

If you want this to go faster please work with Jiri.

> I'd suggest we develop the proposal on current mainline, and
> switch to the new attestation subsystem once it lands. As I
> understand it, for us that is mostly just a matter of switching
> to a different set of APIs.

It isn't, one activity is moving the policy and ROT multiplexer into a
shared subsystem, the other is building a ROT multiplexer into IMA for
only IMA to use.

Jaon
