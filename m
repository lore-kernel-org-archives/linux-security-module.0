From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 8 Jun 2017 19:37:19 +0100
Subject: [PATCH v2 0/1]  Add Trusted Path Execution as a stackable LSM
In-Reply-To: <20170608034349.31876-1-matt@nmatt.com>
References: <20170608034349.31876-1-matt@nmatt.com>
Message-ID: <20170608193719.2d9e8d17@lxorguk.ukuu.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> http://phrack.org/issues/52/6.html#article
> 
> | A trusted path is one that is inside a root owned directory that
> | is not group or world writable.  /bin, /usr/bin, /usr/local/bin, are
> | (under normal circumstances) considered trusted.  Any non-root
> | users home directory is not trusted, nor is /tmp.

Note that in the real world the trusted path would and should also
require that any elements of the path above that point are also locked
down if you are using path based models. Ie you need to ensure nobody has
the ability to rename /usr or /usr/local before you trust /usr/local/bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
