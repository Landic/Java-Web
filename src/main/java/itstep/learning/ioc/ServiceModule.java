package itstep.learning.ioc;

import com.google.inject.AbstractModule;
import itstep.learning.filters.*;
import itstep.learning.services.kdf.KdfService;
import itstep.learning.services.kdf.PbKdf1Service;
import itstep.learning.services.db.DbService;
import itstep.learning.services.db.MySqlDbService;
import itstep.learning.services.hash.HashService;
import itstep.learning.services.hash.MdSHashService;

public class ServiceModule extends AbstractModule {
    @Override
    protected void configure() {
        bind(HashService.class).to(MdSHashService.class);
        bind(KdfService.class).to(PbKdf1Service.class);
        bind(DbService.class).to(MySqlDbService.class);
    }
}
