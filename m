Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796888;
	b=a+TJ6plqf8HkzLKLLfuRLhEwouKUBsnwLU2hPRddg7uyG+3D3jg7oTw5AFYXyiIaiwH5
	 c31Hpm/P2u4ZTfJTmhuRrTm2Hf/wn3KAFK4ypkMbQGbvdRdQzFlx7lPPCPGCqnC1bFMAV
	 h4G8K6Vb7xFuXqx02MvPhTR2/avSILeLEcBCmhzOKEJrskYCCOKMBAoo/cZKBk8stPc9Z
	 h5xTcEfHq0TjOWpaCPT5z+dhbqP8Alfo70crwNNogYeI3DNR4UNmzLqxu4Rad6KWP5boI
	 wzfEHToPBfZKJQ0d08Hf6afd6Vm+m56zP76WX5xFW+s9gYLupZT0yQ4TzNTBrs3zk7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796888;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=c4qt7wJmo33DH5hr5919v3DQD2BX8Lp+y10YBFjPKmk=;
	b=Yyj4QCg7GMEQ0mUMMNClOccsyT7/ywOO0tduvnTFzV3YQtvhtIk/3BdOhzfiJ6nFZLrO
	 /CDedh/gVnTai0dXPORTgTTiO8a/bopWXGSXUit5JHUnOEefwm0ppp6EWDWTS8C0I7u9W
	 FtJG79oWUD2e8HX36AQUHujAI6FwXPWux7ZubtqgtMlZ0biOqzOZZlZcIRVC51kQ8hcEh
	 73h1jHK9wIl1BtcKNQHiryveSCzZ0yqXvRpBv493K6J1r0apoDxw6szlU/2YtRISr899t
	 3/68xbp3OhPTKaomE20Ec7AMf7y4Xy1nOb8n7xDmXEUqelr6LUSNxp1XOvuY+4ovhig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tDBgDGsD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC48606A323;
	Fri, 27 Nov 2026 16:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tDBgDGsD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925061570;
	Fri, 27 Nov 2026 08:28:03 -0800 (PST)
Received: from [10.57.71.121] (unknown [10.57.71.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB863F632;
	Fri, 27 Nov 2026 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795796886; bh=uvuUXT6/oqsW0UDpUW3bxTylCGwKduT/Ak8GOkRy0JI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tDBgDGsDThNcbZ/lRt+L05X+6ny7A+3HRqTsQbrQsJ2FvfB/00IVOcWQzTiPzD1C3
	 UIxSjIS/Jj4KtHiTh778z9A54Dxs9VRSk16Yiuh6Eb6+a2vsIyCvRZTOGpVDmc4Jhv
	 iF5991BtBv4GBMMLieU7slocKD2Zui4XCnT02ssA=
Message-ID: <3a46bcc3-33bb-4c9d-a3e5-44144406dbda@arm.com>
Date: Fri, 27 Nov 2026 16:28:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] arm64: acpi: Enable ACPI CCEL support
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Steven Price <steven.price@arm.com>,
 Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Sudeep Holla <sudeep.holla@kernel.org>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-3-df3230afce8f@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261127-arm_cca_mr-v3-3-df3230afce8f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2026 15:32, Yeoreum Yun wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
> As per UEFI specifications NVS memory is reserved for Firmware use even
> after exiting boot services. Thus map the region as read-only.
> 
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   arch/arm64/kernel/acpi.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 681aa2bbc3995..3d6335db882d3 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -354,6 +354,17 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>   			prot = PAGE_KERNEL_RO;
>   			break;
>   
> +		case EFI_ACPI_MEMORY_NVS:
> +			/*
> +			 * ACPI NVS marks an area reserved for use by the
> +			 * firmware, even after exiting the boot service.
> +			 * This may be used by the firmware for sharing dynamic
> +			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
> +			 * as read-only.
> +			 */
> +			prot = PAGE_KERNEL_RO;
> +			break;
> +

Unfortunately this breaks some platforms, where the NVS must be mapped
R/W. Thats why we dropped this patch.

https://lore.kernel.org/all/20251124103329.363afcc6@foz.lan

Cheers
Suzuki

>   		case EFI_ACPI_RECLAIM_MEMORY:
>   			/*
>   			 * ACPI reclaim memory is used to pass firmware tables
> 

