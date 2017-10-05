From: fweimer@redhat.com (Florian Weimer)
Date: Thu, 5 Oct 2017 14:33:30 +0200
Subject: Draft manpage explaining kernel lockdown
In-Reply-To: <7969.1507201224@warthog.procyon.org.uk>
References: <7969.1507201224@warthog.procyon.org.uk>
Message-ID: <3765ad08-2c73-7285-02e1-e04f31dde3fd@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/05/2017 01:00 PM, David Howells wrote:
> Lockdown is typically enabled during boot and may be terminated, if configured,
> by typing a special key combination on a directly attached physical keyboard.

Does this include a Bluetooth keyboard (which might not actually exist 
and might in reality be another server in the same rack, of course).

Thanks,
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
