From: why2jjj.linux@gmail.com (J Freyensee)
Date: Mon, 5 Mar 2018 11:37:10 -0800
Subject: [PATCH 2/7] genalloc: selftest
In-Reply-To: <20180228200620.30026-3-igor.stoppa@huawei.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
	<20180228200620.30026-3-igor.stoppa@huawei.com>
Message-ID: <488cc366-bd10-425c-ef62-ce8536e3c62a@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> +
> +/*
> + * In case of failure of any of these tests, memory corruption is almost
> + * guarranteed; allowing the boot to continue means risking to corrupt
> + * also any filesystem/block device accessed write mode.
> + * Therefore, BUG_ON() is used, when testing.
> + */
> +
> +

I like the explanation; good background info on why something is 
implemented the way it is :-).

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
