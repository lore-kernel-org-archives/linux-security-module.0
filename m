From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 19 May 2017 09:33:44 -0500
Subject: [kernel-hardening] Re: [PATCH v6 0/2] security: tty: make
	TIOCSTI ioctl require CAP_SYS_ADMIN
In-Reply-To: <CANA3KFWF-=6AWZKAc1ijyoL5vRAwPnwngZZEP9=5+AFgnMv1rg@mail.gmail.com>
References: <20170515215752.4e9f3826@alans-desktop>
	<CANA3KFU6Aor=NjdC49XpX=h29vSpeiDNn78en7sbZFosAcntGw@mail.gmail.com>
	<5c5c9b06-d2ec-c2e5-3ea2-463f315428f6@nmatt.com>
	<CANA3KFUh6Q+Pq6Srh-dQv0gaRy4zUJAJcyGLYoDFH+MfTycp+A@mail.gmail.com>
	<1a1730f3-5378-1ce5-77a9-b9bc8cd5c90b@nmatt.com>
	<CAGXu5jJrEw1WOGniTV4Jhv_mO2zHxmXJqpzUs7BOUJNpCU1MNg@mail.gmail.com>
	<20170517174113.69d1cbaa@alans-desktop>
	<1495045540.1619.1.camel@gmail.com>
	<CAGXu5jL9GUyVYf3d+13UE7UHd+CvUzVwasyCfUmF+ykaY5rpOQ@mail.gmail.com>
	<CANA3KFWF-=6AWZKAc1ijyoL5vRAwPnwngZZEP9=5+AFgnMv1rg@mail.gmail.com>
Message-ID: <20170519143344.GA15983@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 19, 2017 at 12:48:17PM +1000, Peter Dolding wrote:
> Using cap_sys_admin as fix is like removing car windsheld because
> vision is being blocked by a rock hitting it.

Nonsense.  If the application has cap_sys_admin then it is less contained and
more trusted anyway.  If I went to the trouble to run an application in a
private user namespace (where it can have cap_sys_admin, but not targeted
at my tty) then it should be more contained.  That's the point of targeted
capabilities.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
