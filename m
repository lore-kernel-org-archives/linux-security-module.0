From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 16 Nov 2017 12:11:13 -0500
Subject: [PATCH 0/4] treewide: Fix line continuation formats
In-Reply-To: <cover.1510845910.git.joe@perches.com>
References: <cover.1510845910.git.joe@perches.com>
Message-ID: <1510852273.3711.448.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> Avoid using line continations in formats as that causes unexpected
> output.

Is having lines greater than 80 characters the preferred method?
?Could you add quotes before the backlash and before the first word on
the next line instead?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
