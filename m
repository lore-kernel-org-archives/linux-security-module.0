From: james.l.morris@oracle.com (James Morris)
Date: Tue, 5 Dec 2017 11:18:10 +1100 (AEDT)
Subject: [PATCH] security: keys: remove redundant assignment to key_ref
In-Reply-To: <20171204181424.15808-1-colin.king@canonical.com>
References: <20171204181424.15808-1-colin.king@canonical.com>
Message-ID: <alpine.LFD.2.20.1712051116130.21642@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 4 Dec 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable key_ref is being assigned a value that is never read;
> key_ref is being re-assigned a few statements later.  Hence this
> assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I think a general cleanup in that function to make all of these follow the 
pattern:

	if (something) {
		key_ref = ERR_PTR(-error);
		goto error;
	}

rather than unconditionally setting the error first, would be better, but 
this is a clear enough fix on its own.

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
