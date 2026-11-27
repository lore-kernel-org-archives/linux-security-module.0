Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799343;
	b=foHxsMzJVKXPMktautZZ4s1CrD+c0/76cHQSC6Ndm+LxTmMm9b2/+9o0WWZqomXq2Ee/
	 sE0mnjszQSw4j4AJzuE4L0Wo5DQNQshpnL19fucQoVJCP5Tja/EhwCpRNa8A2YkwdsR7K
	 Bi0llJc2PnKIVWxhhy6WYr3crF9dc5fojmZq6WhCOPOANlnA0DE7HCNiZ+4UKvK+YySx8
	 ZvsCXKOUwDW7/hXnEr5kU1aXpPrbLUU5sd+E8nTXR1AGgKTOCXoq6SwFEloyLSSaqWjpd
	 TcYwegWAY0O95MbbilUPwA6vYQzTXW1HvCZubrgaxcmw9QnqYkcCeASczEl44obQGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
	b=bVhvTbNGxOyfouhjXGRe043deKxjOY6K3/IoUkbuRw2fDJRtdGxU6SCtVUF2I74sPgjN
	 xkNer5FiTm366PbUzZbUaMtPQio8A8wgFVdkJ5o+/ObcEc/w+l2ziCb27IpQdoTN4MIqa
	 LkUNRlnJtyWyfW09FRRf6tAStJMjKSJKPsTMVqcnU0MPD2n9d4WLOsV7CdPDDbYpdB5wi
	 wECcwEoeuQf6lXWS2yH1wUCG6XFjS8DhO3tDSqTHHobxP8csfDN+tLfe5IV5l6cpQ6V4s
	 dtbFYpICbUUjoVmTw+q4AOqtfpeGGUx1pq1atFGFy4o6d5wW1g8wGaSplCu/lJCV+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NpcMn18Z;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC09606A327
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC09606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NpcMn18Z
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e7fc8265aso30128496d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795799341; x=1796404141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=NpcMn18ZOcBUH/K57xXEmosR6TjqGtaHb4iOQyIq0GgNDqO6dAa3ahAGzdoMm6DK/R
         3dkns94RmQsNEaf/27kIYiOKFNzoSKhIXNccUkBguWLK26AIyGo+A089UsFFPfbNz3JT
         fRNukHbF1g5uEH+w2aeet1LpRPQxG0BgLshkGNvKg+X6WFsNVdvtlTlH7jbh0mMU3AE+
         droQd+7Wzvs1ZZv0Bm+V2UKWtzqHa4QvPeJsxPzSnXUzGeAIakkUFw1mjKjdYkbgy2S8
         Y9PJhCrLM+XiW39othsK/ZS90eIpfnqQ3cGzLWFY0EcectQslbi4vHXfem+Makltaxhy
         GuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799341; x=1796404141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=EnIxB4g/uBRa5uJkeV7V2DxoY2oWU9Fb9itEoy6qlJu9Bc4sBrO9ZmPRjkj9a7zxXL
         z98i3XtH9XJ84EOt2O1gaw4/Ooi8GHM6yau5n25Ky30mwwybN57BZiXH7zhk+udfJLc5
         geWQIgHoM3QcF7DX7575oNTpXGwAux+KydSFRAiK2XKt29rlnlMmXmcHAAh7tpBR2Tpo
         riputSlZdHCGayfyR2U6bWCIOLPFOw31rE/xNIV4ZoxHgkHsuTum2/B1S2JeViR5Q5Sy
         crWDCLSbVupkOxURQP1RB7ru1n/LsbekIGAX42722TLVfyrsY3fNJ2o/nJ7mfuv29b3C
         IGpg==
X-Forwarded-Encrypted: i=1; AL+hErGxol9s1y9+dTjqZ+Hauqvj88YuhwWKecvXteAwJenJIskoMj4Nljwv/b+xGpWN7/d5sH+gQLVBudX0ShzVT0cWkqZRpkw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O3Oml0hMjzjFgvDrnwtoWctgihOKhkYQUA3/g+83kfwLme01t
	NDIIw34WuqGYmL3bDzWKONthdjShrPS15x6Skqyj1SbgAHYLT2aOg6bGKAPuxXcYuVY=
X-Gm-Gg: AZFdTZfTTts9xFD6DnqyJYBI/edB6zq9RxpoGrlrvxZotNTWwHu8yMdhF6O1Yen9Mzm
	3WBMI5UkcEq9BeQ0tBIOaQISRmwXwBp5gnwaG04bWv2+fxAiqSY2PZkYKmWiAXbEHXX7mb8oYmL
	5SyatwAxwxLS2FJf/YfHFUT0qH8qLUwoUToKp3gcLStEgj8BFoAxOXZfs/nFRf6VezGfZq6OAqw
	tU9GCJ7Lor/7kBFJpMp8R0bDu431+ykEaxIkLsk43fyfS5ho5/Ac6I33wBF9cnwQnCnK6BAlMql
	N1nHgN9ejF2xv0TMCnetPV5pSP+879ZttUryQf0RqqX9psPkn2Z1Dl2Jpb1x6S3Il43hOlqyz0m
	UQrfmhYjGXJAobzWP11XFv+h7w6kJcX1NRe9WtojfXBp/eN10jS7vn9NuByHUR69olrGZJhSh/C
	RofuXS1yLN/rAVqq4Vf/sH9IitEpd2POy/NW2hQeHCQ89U9MO2cFKyDhyb1dUueF2JBqXgtA2l8
	6mkHgbc7QraQ7nWO3OvVhwn6w3X4jM4vVhv4ZA3HysfShIy5yIV6UGEYJdbAB1Gyz8Jus3Mng52
	AeLM+A==
X-Received: by 2002:a05:620a:7206:b0:94a:889:5a33 with SMTP id af79cd13be357-94a08896165mr1311739085a.30.1795799341642;
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm1875035285a.37.2026.11.27.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWzRU-000000079ec-2Xcr;
	Fri, 27 Nov 2026 13:09:00 -0400
Date: Fri, 27 Nov 2026 13:09:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 8/8] selftest: attestation: add
 cca_guest_attestation_test selftest
Message-ID: <20261127170900.GU246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>

On Fri, Nov 27, 2026 at 03:33:03PM +0000, Yeoreum Yun wrote:
> Add CCA Realm Guest attestation selftest to test evidence-get, mr_read
> and mr_extend interfaces.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  tools/testing/selftests/attestation/.gitignore     |   1 +
>  tools/testing/selftests/attestation/Makefile       |   9 +-
>  .../attestation/cca_guest_attestation_test.c       | 517 +++++++++++++++++++++
>  3 files changed, 524 insertions(+), 3 deletions(-)

FWIW, I really want to have an attestation userspace project and there
is where stuff like this should end up living..

We haven't got to launching a github for it yet, but that's the plan
anyhow.

Jason
